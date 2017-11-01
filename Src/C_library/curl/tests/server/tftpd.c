/***************************************************************************
 *                                  _   _ ____  _
 *  Project                     ___| | | |  _ \| |
 *                             / __| | | | |_) | |
 *                            | (__| |_| |  _ <| |___
 *                             \___|\___/|_| \_\_____|
 *
 *
 * Trivial file transfer protocol server.
 *
 * This code includes many modifications by Jim Guyton <guyton@rand-unix>
 *
 * This source file was started based on netkit-tftpd 0.17
 * Heavily modified for curl's test suite
 */

/*
 * Copyright (c) 1983, 2016 Regents of the University of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *      This product includes software developed by the University of
 *      California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include "server_setup.h"

#ifdef HAVE_SYS_IOCTL_H
#include <sys/ioctl.h>
#endif
#ifdef HAVE_SIGNAL_H
#include <signal.h>
#endif
#ifdef HAVE_FCNTL_H
#include <fcntl.h>
#endif
#ifdef HAVE_NETINET_IN_H
#include <netinet/in.h>
#endif
#ifdef HAVE_ARPA_INET_H
#include <arpa/inet.h>
#endif
#ifdef HAVE_ARPA_TFTP_H
#include <arpa/tftp.h>
#else
#include "tftp.h"
#endif
#ifdef HAVE_NETDB_H
#include <netdb.h>
#endif
#ifdef HAVE_SYS_FILIO_H
/* FIONREAD on Solaris 7 */
#include <sys/filio.h>
#endif

#include <setjmp.h>

#ifdef HAVE_PWD_H
#include <pwd.h>
#endif

#define ENABLE_CURLX_PRINTF
/* make the curlx header define all printf() functions to use the curlx_*
   versions instead */
#include "curlx.h" /* from the private lib dir */
#include "getpart.h"
#include "util.h"
#include "server_sockaddr.h"

/* include memdebug.h last */
#include "memdebug.h"

/*****************************************************************************
*                      STRUCT DECLARATIONS AND DEFINES                       *
*****************************************************************************/

#ifndef PKTSIZE
#define PKTSIZE (SEGSIZE + 4)  /* SEGSIZE defined in arpa/tftp.h */
#endif

struct testcase {
  char *buffer;   /* holds the file data to send to the client */
  size_t bufsize; /* size of the data in buffer */
  char *rptr;     /* read pointer into the buffer */
  size_t rcount;  /* amount of data left to read of the file */
  long testno;    /* test case number */
  int ofile;      /* file descriptor for output file when uploading to us */

  int writedelay; /* number of seconds between each packet */
};

struct formats {
  const char *f_mode;
  int f_convert;
};

struct errmsg {
  int e_code;
  const char *e_msg;
};

typedef union {
  struct tftphdr hdr;
  char storage[PKTSIZE];
} tftphdr_storage_t;

/*
 * bf.counter values in range [-1 .. SEGSIZE] represents size of data in the
 * bf.buf buffer. Additionally it can also hold flags BF_ALLOC or BF_FREE.
 */

struct bf {
  int counter;            /* size of data in buffer, or flag */
  tftphdr_storage_t buf;  /* room for data packet */
};

#define BF_ALLOC -3       /* alloc'd but not yet filled */
#define BF_FREE  -2       /* free */

#define opcode_RRQ   1
#define opcode_WRQ   2
#define opcode_DATA  3
#define opcode_ACK   4
#define opcode_ERROR 5

#define TIMEOUT      5

#undef MIN
#define MIN(x,y) ((x)<(y)?(x):(y))

#ifndef DEFAULT_LOGFILE
#define DEFAULT_LOGFILE "log/tftpd.log"
#endif

#define REQUEST_DUMP  "log/server.input"

#define DEFAULT_PORT 8999 /* UDP */

/*****************************************************************************
*                              GLOBAL VARIABLES                              *
*****************************************************************************/

static struct errmsg errmsgs[] = {
  { EUNDEF,       "Undefined error code" },
  { ENOTFOUND,    "File not found" },
  { EACCESS,      "Access violation" },
  { ENOSPACE,     "Disk full or allocation exceeded" },
  { EBADOP,       "Illegal TFTP operation" },
  { EBADID,       "Unknown transfer ID" },
  { EEXISTS,      "File already exists" },
  { ENOUSER,      "No such user" },
  { -1,           0 }
};

static struct formats formata[] = {
  { "netascii",   1 },
  { "octet",      0 },
  { NULL,         0 }
};

static struct bf bfs[2];

static int nextone;     /* index of next buffer to use */
static int current;     /* index of buffer in use */

                           /* control flags for crlf conversions */
static int newline = 0;    /* fillbuf: in middle of newline expansion */
static int prevchar = -1;  /* putbuf: previous char (cr check) */

static tftphdr_storage_t buf;
static tftphdr_storage_t ackbuf;

static srvr_sockaddr_union_t from;
static curl_socklen_t fromlen;

static curl_socket_t peer = CURL_SOCKET_BAD;

static unsigned int timeout;
static unsigned int maxtimeout = 5 * TIMEOUT;

#ifdef ENABLE_IPV6
static bool use_ipv6 = FALSE;
#endif
static const char *ipv_inuse = "IPv4";

const  char *serverlogfile = DEFAULT_LOGFILE;
static const char *pidname = ".tftpd.pid";
static int serverlogslocked = 0;
static int wrotepidfile = 0;

#ifdef HAVE_SIGSETJMP
static sigjmp_buf timeoutbuf;
#endif

#if defined(HAVE_ALARM) && defined(SIGALRM)
static const unsigned int rexmtval = TIMEOUT;
#endif

/* do-nothing macro replacement for systems which lack siginterrupt() */

#ifndef HAVE_SIGINTERRUPT
#define siginterrupt(x,y) do {} while(0)
#endif

/* vars used to keep around previous signal handlers */

typedef RETSIGTYPE (*SIGHANDLER_T)(int);

#ifdef SIGHUP
static SIGHANDLER_T old_sighup_handler  = SIG_ERR;
#endif

#ifdef SIGPIPE
static SIGHANDLER_T old_sigpipe_handler = SIG_ERR;
#endif

#ifdef SIGINT
static SIGHANDLER_T old_sigint_handler  = SIG_ERR;
#endif

#ifdef SIGTERM
static SIGHANDLER_T old_sigterm_handler = SIG_ERR;
#endif

#if defined(SIGBREAK) && defined(WIN32)
static SIGHANDLER_T old_sigbreak_handler = SIG_ERR;
#endif

/* var which if set indicates that the program should finish execution */

SIG_ATOMIC_T got_exit_signal = 0;

/* if next is set indicates the first signal handled in exit_signal_handler */

static volatile int exit_signal = 0;

/*****************************************************************************
*                            FUNCTION PROTOTYPES                             *
*****************************************************************************/

static struct tftphdr *rw_init(int);

static struct tftphdr *w_init(void);

static struct tftphdr *r_init(void);

static void read_ahead(struct testcase *test, int convert);

static ssize_t write_behind(struct testcase *test, int convert);

static int synchnet(curl_socket_t);

static int do_tftp(struct testcase *test, struct tftphdr *tp, ssize_t size);

static int validate_access(struct testcase *test, const char *fname, int mode);

static void sendtftp(struct testcase *test, struct formats *pf);

static void recvtftp(struct testcase *test, struct formats *pf);

static void nak(int error);

#if defined(HAVE_ALARM) && defined(SIGALRM)

static void mysignal(int sig, void (*handler)(int));

static void timer(int signum);

static void justtimeout(int signum);

#endif /* HAVE_ALARM && SIGALRM */

static RETSIGTYPE exit_signal_handler(int signum);

static void install_signal_handlers(void);

static void restore_signal_handlers(void);

/*****************************************************************************
*                          FUNCTION IMPLEMENTATIONS                          *
*****************************************************************************/

#if defined(HAVE_ALARM) && defined(SIGALRM)

/*
 * Like signal(), but with well-defined semantics.
 */
static void mysignal(int sig, void (*handler)(int))
{
  struct sigaction sa;
  memset(&sa, 0, sizeof(sa));
  sa.sa_handler = handler;
  sigaction(sig, &sa, NULL);
}

static void timer(int signum)
{
  (void)signum;

  logmsg("alarm!");

  timeout += rexmtval;
  if(timeout >= maxtimeout) {
    if(wrotepidfile) {
      wrotepidfile = 0;
      unlink(pidname);
    }
    if(serverlogslocked) {
      serverlogslocked = 0;
      clear_advisor_read_lock(SERVERLOGS_LOCK);
    }
    exit(1);
  }
#ifdef HAVE_SIGSETJMP
  siglongjmp(timeoutbuf, 1);
#endif
}

static void justtimeout(int signum)
{
  (void)signum;
}

#endif /* HAVE_ALARM && SIGALRM */

/* signal handler that will be triggered to indicate that the program
  should finish its execution in a controlled manner as soon as possible.
  The first time this is called it will set got_exit_signal to one and
  store in exit_signal the signal that triggered its execution. */

static RETSIGTYPE exit_signal_handler(int signum)
{
  int old_errno = errno;
  if(got_exit_signal == 0) {
    got_exit_signal = 1;
    exit_signal = signum;
  }
  (void)signal(signum, exit_signal_handler);
  errno = old_errno;
}

static void install_signal_handlers(void)
{
#ifdef SIGHUP
  /* ignore SIGHUP signal */
  old_sighup_handler = signal(SIGHUP, SIG_IGN);
  if(old_sighup_handler == SIG_ERR)
    logmsg("cannot install SIGHUP handler: %s", strerror(errno));
#endif
#ifdef SIGPIPE
  /* ignore SIGPIPE signal */
  old_sigpipe_handler = signal(SIGPIPE, SIG_IGN);
  if(old_sigpipe_handler == SIG_ERR)
    logmsg("cannot install SIGPIPE handler: %s", strerror(errno));
#endif
#ifdef SIGINT
  /* handle SIGINT signal with our exit_signal_handler */
  old_sigint_handler = signal(SIGINT, exit_signal_handler);
  if(old_sigint_handler == SIG_ERR)
    logmsg("cannot install SIGINT handler: %s", strerror(errno));
  else
    siginterrupt(SIGINT, 1);
#endif
#ifdef SIGTERM
  /* handle SIGTERM signal with our exit_signal_handler */
  old_sigterm_handler = signal(SIGTERM, exit_signal_handler);
  if(old_sigterm_handler == SIG_ERR)
    logmsg("cannot install SIGTERM handler: %s", strerror(errno));
  else
    siginterrupt(SIGTERM, 1);
#endif
#if defined(SIGBREAK) && defined(WIN32)
  /* handle SIGBREAK signal with our exit_signal_handler */
  old_sigbreak_handler = signal(SIGBREAK, exit_signal_handler);
  if(old_sigbreak_handler == SIG_ERR)
    logmsg("cannot install SIGBREAK handler: %s", strerror(errno));
  else
    siginterrupt(SIGBREAK, 1);
#endif
}

static void restore_signal_handlers(void)
{
#ifdef SIGHUP
  if(SIG_ERR != old_sighup_handler)
    (void)signal(SIGHUP, old_sighup_handler);
#endif
#ifdef SIGPIPE
  if(SIG_ERR != old_sigpipe_handler)
    (void)signal(SIGPIPE, old_sigpipe_handler);
#endif
#ifdef SIGINT
  if(SIG_ERR != old_sigint_handler)
    (void)signal(SIGINT, old_sigint_handler);
#endif
#ifdef SIGTERM
  if(SIG_ERR != old_sigterm_handler)
    (void)signal(SIGTERM, old_sigterm_handler);
#endif
#if defined(SIGBREAK) && defined(WIN32)
  if(SIG_ERR != old_sigbreak_handler)
    (void)signal(SIGBREAK, old_sigbreak_handler);
#endif
}

/*
 * init for either read-ahead or write-behind.
 * zero for write-behind, one for read-head.
 */
static struct tftphdr *rw_init(int x)
{
  newline = 0;                    /* init crlf flag */
  prevchar = -1;
  bfs[0].counter =  BF_ALLOC;     /* pass out the first buffer */
  current = 0;
  bfs[1].counter = BF_FREE;
  nextone = x;                    /* ahead or behind? */
  return &bfs[0].buf.hdr;
}

static struct tftphdr *w_init(void)
{
  return rw_init(0); /* write-behind */
}

static struct tftphdr *r_init(void)
{
  return rw_init(1); /* read-ahead */
}

/* Have emptied current buffer by sending to net and getting ack.
   Free it and return next buffer filled with data.
 */
static int readit(struct testcase *test, struct tftphdr **dpp,
                  int convert /* if true, convert to ascii */)
{
  struct bf *b;

  bfs[current].counter = BF_FREE; /* free old one */
  current = !current;             /* "incr" current */

  b = &bfs[current];              /* look at new buffer */
  if(b->counter == BF_FREE)      /* if it's empty */
    read_ahead(test, convert);    /* fill it */

  *dpp = &b->buf.hdr;             /* set caller's ptr */
  return b->counter;
}

/*
 * fill the input buffer, doing ascii conversions if requested
 * conversions are  lf -> cr, lf  and cr -> cr, nul
 */
static void read_ahead(struct testcase *test,
                       int convert /* if true, convert to ascii */)
{
  int i;
  char *p;
  int c;
  struct bf *b;
  struct tftphdr *dp;

  b = &bfs[nextone];              /* look at "next" buffer */
  if(b->counter != BF_FREE)      /* nop if not free */
    return;
  nextone = !nextone;             /* "incr" next buffer ptr */

  dp = &b->buf.hdr;

  if(convert == 0) {
    /* The former file reading code did this:
       b->counter = read(fileno(file), dp->th_data, SEGSIZE); */
    size_t copy_n = MIN(SEGSIZE, test->rcount);
    memcpy(dp->th_data, test->rptr, copy_n);

    /* decrease amount, advance pointer */
    test->rcount -= copy_n;
    test->rptr += copy_n;
    b->counter = (int)copy_n;
    return;
  }

  p = dp->th_data;
  for(i = 0 ; i < SEGSIZE; i++) {
    if(newline) {
      if(prevchar == '\n')
        c = '\n';       /* lf to cr,lf */
      else
        c = '\0';       /* cr to cr,nul */
      newline = 0;
    }
    else {
      if(test->rcount) {
        c = test->rptr[0];
        test->rptr++;
        test->rcount--;
      }
      else
        break;
      if(c == '\n' || c == '\r') {
        prevchar = c;
        c = '\r';
        newline = 1;
      }
    }
    *p++ = (char)c;
  }
  b->counter = (int)(p - dp->th_data);
}

/* Update count associated with the buffer, get new buffer from the queue.
   Calls write_behind only if next buffer not available.
 */
static int writeit(struct testcase *test, struct tftphdr * volatile *dpp,
                   int ct, int convert)
{
  bfs[current].counter = ct;      /* set size of data to write */
  current = !current;             /* switch to other buffer */
  if(bfs[current].counter != BF_FREE)     /* if not free */
    write_behind(test, convert);     /* flush it */
  bfs[current].counter = BF_ALLOC;        /* mark as alloc'd */
  *dpp =  &bfs[current].buf.hdr;
  return ct;                      /* this is a lie of course */
}

/*
 * Output a buffer to a file, converting from netascii if requested.
 * CR, NUL -> CR  and CR, LF => LF.
 * Note spec is undefined if we get CR as last byte of file or a
 * CR followed by anything else.  In this case we leave it alone.
 */
static ssize_t write_behind(struct testcase *test, int convert)
{
  char *writebuf;
  int count;
  int ct;
  char *p;
  int c;                          /* current character */
  struct bf *b;
  struct tftphdr *dp;

  b = &bfs[nextone];
  if(b->counter < -1)            /* anything to flush? */
    return 0;                     /* just nop if nothing to do */

  if(!test->ofile) {
    char outfile[256];
    snprintf(outfile, sizeof(outfile), "log/upload.%ld", test->testno);
#ifdef WIN32
    test->ofile = open(outfile, O_CREAT|O_RDWR|O_BINARY, 0777);
#else
    test->ofile = open(outfile, O_CREAT|O_RDWR, 0777);
#endif
    if(test->ofile == -1) {
      logmsg("Couldn't create and/or open file %s for upload!", outfile);
      return -1; /* failure! */
    }
  }

  count = b->counter;             /* remember byte count */
  b->counter = BF_FREE;           /* reset flag */
  dp = &b->buf.hdr;
  nextone = !nextone;             /* incr for next time */
  writebuf = dp->th_data;

  if(count <= 0)
    return -1;                    /* nak logic? */

  if(convert == 0)
    return write(test->ofile, writebuf, count);

  p = writebuf;
  ct = count;
  while(ct--) {                   /* loop over the buffer */
    c = *p++;                     /* pick up a character */
    if(prevchar == '\r') {        /* if prev char was cr */
      if(c == '\n')               /* if have cr,lf then just */
        lseek(test->ofile, -1, SEEK_CUR); /* smash lf on top of the cr */
      else
        if(c == '\0')             /* if have cr,nul then */
          goto skipit;            /* just skip over the putc */
      /* else just fall through and allow it */
    }
    /* formerly
       putc(c, file); */
    if(1 != write(test->ofile, &c, 1))
      break;
    skipit:
    prevchar = c;
  }
  return count;
}

/* When an error has occurred, it is possible that the two sides are out of
 * synch.  Ie: that what I think is the other side's response to packet N is
 * really their response to packet N-1.
 *
 * So, to try to prevent that, we flush all the input queued up for us on the
 * network connection on our host.
 *
 * We return the number of packets we flushed (mostly for reporting when trace
 * is active).
 */

static int synchnet(curl_socket_t f /* socket to flush */)
{

#if defined(HAVE_IOCTLSOCKET)
  unsigned long i;
#else
  int i;
#endif
  int j = 0;
  char rbuf[PKTSIZE];
  srvr_sockaddr_union_t fromaddr;
  curl_socklen_t fromaddrlen;

  for(;;) {
#if defined(HAVE_IOCTLSOCKET)
    (void) ioctlsocket(f, FIONREAD, &i);
#else
    (void) ioctl(f, FIONREAD, &i);
#endif
    if(i) {
      j++;
#ifdef ENABLE_IPV6
      if(!use_ipv6)
#endif
        fromaddrlen = sizeof(fromaddr.sa4);
#ifdef ENABLE_IPV6
      else
        fromaddrlen = sizeof(fromaddr.sa6);
#endif
      (void) recvfrom(f, rbuf, sizeof(rbuf), 0,
                      &fromaddr.sa, &fromaddrlen);
    }
    else
      break;
  }
  return j;
}

int main(int argc, char **argv)
{
  srvr_sockaddr_union_t me;
  struct tftphdr *tp;
  ssize_t n = 0;
  int arg = 1;
  unsigned short port = DEFAULT_PORT;
  curl_socket_t sock = CURL_SOCKET_BAD;
  int flag;
  int rc;
  int error;
  long pid;
  struct testcase test;
  int result = 0;

  memset(&test, 0, sizeof(test));

  while(argc>arg) {
    if(!strcmp("--version", argv[arg])) {
      printf("tftpd IPv4%s\n",
#ifdef ENABLE_IPV6
             "/IPv6"
#else
             ""
#endif
             );
      return 0;
    }
    else if(!strcmp("--pidfile", argv[arg])) {
      arg++;
      if(argc>arg)
        pidname = argv[arg++];
    }
    else if(!strcmp("--logfile", argv[arg])) {
      arg++;
      if(argc>arg)
        serverlogfile = argv[arg++];
    }
    else if(!strcmp("--ipv4", argv[arg])) {
#ifdef ENABLE_IPV6
      ipv_inuse = "IPv4";
      use_ipv6 = FALSE;
#endif
      arg++;
    }
    else if(!strcmp("--ipv6", argv[arg])) {
#ifdef ENABLE_IPV6
      ipv_inuse = "IPv6";
      use_ipv6 = TRUE;
#endif
      arg++;
    }
    else if(!strcmp("--port", argv[arg])) {
      arg++;
      if(argc>arg) {
        char *endptr;
        unsigned long ulnum = strtoul(argv[arg], &endptr, 10);
        if((endptr != argv[arg] + strlen(argv[arg])) ||
           (ulnum < 1025UL) || (ulnum > 65535UL)) {
          fprintf(stderr, "tftpd: invalid --port argument (%s)\n",
                  argv[arg]);
          return 0;
        }
        port = curlx_ultous(ulnum);
        arg++;
      }
    }
    else if(!strcmp("--srcdir", argv[arg])) {
      arg++;
      if(argc>arg) {
        path = argv[arg];
        arg++;
      }
    }
    else {
      puts("Usage: tftpd [option]\n"
           " --version\n"
           " --logfile [file]\n"
           " --pidfile [file]\n"
           " --ipv4\n"
           " --ipv6\n"
           " --port [port]\n"
           " --srcdir [path]");
      return 0;
    }
  }

#ifdef WIN32
  win32_init();
  atexit(win32_cleanup);
#endif

  install_signal_handlers();

  pid = (long)getpid();

#ifdef ENABLE_IPV6
  if(!use_ipv6)
#endif
    sock = socket(AF_INET, SOCK_DGRAM, 0);
#ifdef ENABLE_IPV6
  else
    sock = socket(AF_INET6, SOCK_DGRAM, 0);
#endif

  if(CURL_SOCKET_BAD == sock) {
    error = SOCKERRNO;
    logmsg("Error creating socket: (%d) %s",
           error, strerror(error));
    result = 1;
    goto tftpd_cleanup;
  }

  flag = 1;
  if(0 != setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
            (void *)&flag, sizeof(flag))) {
    error = SOCKERRNO;
    logmsg("setsockopt(SO_REUSEADDR) failed with error: (%d) %s",
           error, strerror(error));
    result = 1;
    goto tftpd_cleanup;
  }

#ifdef ENABLE_IPV6
  if(!use_ipv6) {
#endif
    memset(&me.sa4, 0, sizeof(me.sa4));
    me.sa4.sin_family = AF_INET;
    me.sa4.sin_addr.s_addr = INADDR_ANY;
    me.sa4.sin_port = htons(port);
    rc = bind(sock, &me.sa, sizeof(me.sa4));
#ifdef ENABLE_IPV6
  }
  else {
    memset(&me.sa6, 0, sizeof(me.sa6));
    me.sa6.sin6_family = AF_INET6;
    me.sa6.sin6_addr = in6addr_any;
    me.sa6.sin6_port = htons(port);
    rc = bind(sock, &me.sa, sizeof(me.sa6));
  }
#endif /* ENABLE_IPV6 */
  if(0 != rc) {
    error = SOCKERRNO;
    logmsg("Error binding socket on port %hu: (%d) %s",
           port, error, strerror(error));
    result = 1;
    goto tftpd_cleanup;
  }

  wrotepidfile = write_pidfile(pidname);
  if(!wrotepidfile) {
    result = 1;
    goto tftpd_cleanup;
  }

  logmsg("Running %s version on port UDP/%d", ipv_inuse, (int)port);

  for(;;) {
    fromlen = sizeof(from);
#ifdef ENABLE_IPV6
    if(!use_ipv6)
#endif
      fromlen = sizeof(from.sa4);
#ifdef ENABLE_IPV6
    else
      fromlen = sizeof(from.sa6);
#endif
    n = (ssize_t)recvfrom(sock, &buf.storage[0], sizeof(buf.storage), 0,
                          &from.sa, &fromlen);
    if(got_exit_signal)
      break;
    if(n < 0) {
      logmsg("recvfrom");
      result = 3;
      break;
    }

    set_advisor_read_lock(SERVERLOGS_LOCK);
    serverlogslocked = 1;

#ifdef ENABLE_IPV6
    if(!use_ipv6) {
#endif
      from.sa4.sin_family = AF_INET;
      peer = socket(AF_INET, SOCK_DGRAM, 0);
      if(CURL_SOCKET_BAD == peer) {
        logmsg("socket");
        result = 2;
        break;
      }
      if(connect(peer, &from.sa, sizeof(from.sa4)) < 0) {
        logmsg("connect: fail");
        result = 1;
        break;
      }
#ifdef ENABLE_IPV6
    }
    else {
      from.sa6.sin6_family = AF_INET6;
      peer = socket(AF_INET6, SOCK_DGRAM, 0);
      if(CURL_SOCKET_BAD == peer) {
        logmsg("socket");
        result = 2;
        break;
      }
      if(connect(peer, &from.sa, sizeof(from.sa6)) < 0) {
        logmsg("connect: fail");
        result = 1;
        break;
      }
    }
#endif

    maxtimeout = 5*TIMEOUT;

    tp = &buf.hdr;
    tp->th_opcode = ntohs(tp->th_opcode);
    if(tp->th_opcode == opcode_RRQ || tp->th_opcode == opcode_WRQ) {
      memset(&test, 0, sizeof(test));
      if(do_tftp(&test, tp, n) < 0)
        break;
      free(test.buffer);
    }
    sclose(peer);
    peer = CURL_SOCKET_BAD;

    if(test.ofile > 0) {
      close(test.ofile);
      test.ofile = 0;
    }

    if(got_exit_signal)
      break;

    if(serverlogslocked) {
      serverlogslocked = 0;
      clear_advisor_read_lock(SERVERLOGS_LOCK);
    }

    logmsg("end of one transfer");

  }

tftpd_cleanup:

  if(test.ofile > 0)
    close(test.ofile);

  if((peer != sock) && (peer != CURL_SOCKET_BAD))
    sclose(peer);

  if(sock != CURL_SOCKET_BAD)
    sclose(sock);

  if(got_exit_signal)
    logmsg("signalled to die");

  if(wrotepidfile)
    unlink(pidname);

  if(serverlogslocked) {
    serverlogslocked = 0;
    clear_advisor_read_lock(SERVERLOGS_LOCK);
  }

  restore_signal_handlers();

  if(got_exit_signal) {
    logmsg("========> %s tftpd (port: %d pid: %ld) exits with signal (%d)",
           ipv_inuse, (int)port, pid, exit_signal);
    /*
     * To properly set the return status of the process we
     * must raise the same signal SIGINT or SIGTERM that we
     * caught and let the old handler take care of it.
     */
    raise(exit_signal);
  }

  logmsg("========> tftpd quits");
  return result;
}

/*
 * Handle initial connection protocol.
 */
static int do_tftp(struct testcase *test, struct tftphdr *tp, ssize_t size)
{
  char *cp;
  int first = 1, ecode;
  struct formats *pf;
  char *filename, *mode = NULL;
  int error;
  FILE *server;
#ifdef USE_WINSOCK
  DWORD recvtimeout, recvtimeoutbak;
#endif
  const char *option = "mode"; /* mode is implicit */
  int toggle = 1;

  /* Open request dump file. */
  server = fopen(REQUEST_DUMP, "ab");
  if(!server) {
    error = errno;
    logmsg("fopen() failed with error: %d %s", error, strerror(error));
    logmsg("Error opening file: %s", REQUEST_DUMP);
    return -1;
  }

  /* store input protocol */
  fprintf(server, "opcode: %x\n", tp->th_opcode);

  cp = (char *)&tp->th_stuff;
  filename = cp;
  do {
    bool endofit = true;
    while(cp < &buf.storage[size]) {
      if(*cp == '\0') {
        endofit = false;
        break;
      }
      cp++;
    }
    if(endofit)
      /* no more options */
      break;

    /* before increasing pointer, make sure it is still within the legal
       space */
    if((cp + 1) < &buf.storage[size]) {
      ++cp;
      if(first) {
        /* store the mode since we need it later */
        mode = cp;
        first = 0;
      }
      if(toggle)
        /* name/value pair: */
        fprintf(server, "%s: %s\n", option, cp);
      else {
        /* store the name pointer */
        option = cp;
      }
      toggle ^= 1;
    }
    else
      /* No more options */
      break;
  } while(1);

  if(*cp) {
    nak(EBADOP);
    fclose(server);
    return 3;
  }

  /* store input protocol */
  fprintf(server, "filename: %s\n", filename);

  for(cp = mode; cp && *cp; cp++)
    if(ISUPPER(*cp))
      *cp = (char)tolower((int)*cp);

  /* store input protocol */
  fclose(server);

  for(pf = formata; pf->f_mode; pf++)
    if(strcmp(pf->f_mode, mode) == 0)
      break;
  if(!pf->f_mode) {
    nak(EBADOP);
    return 2;
  }
  ecode = validate_access(test, filename, tp->th_opcode);
  if(ecode) {
    nak(ecode);
    return 1;
  }

#ifdef USE_WINSOCK
  recvtimeout = sizeof(recvtimeoutbak);
  getsockopt(peer, SOL_SOCKET, SO_RCVTIMEO,
             (char *)&recvtimeoutbak, (int *)&recvtimeout);
  recvtimeout = TIMEOUT*1000;
  setsockopt(peer, SOL_SOCKET, SO_RCVTIMEO,
             (const char *)&recvtimeout, sizeof(recvtimeout));
#endif

  if(tp->th_opcode == opcode_WRQ)
    recvtftp(test, pf);
  else
    sendtftp(test, pf);

#ifdef USE_WINSOCK
  recvtimeout = recvtimeoutbak;
  setsockopt(peer, SOL_SOCKET, SO_RCVTIMEO,
             (const char *)&recvtimeout, sizeof(recvtimeout));
#endif

  return 0;
}

/* Based on the testno, parse the correct server commands. */
static int parse_servercmd(struct testcase *req)
{
  FILE *stream;
  char *filename;
  int error;

  filename = test2file(req->testno);

  stream = fopen(filename, "rb");
  if(!stream) {
    error = errno;
    logmsg("fopen() failed with error: %d %s", error, strerror(error));
    logmsg("  [1] Error opening file: %s", filename);
    logmsg("  Couldn't open test file %ld", req->testno);
    return 1; /* done */
  }
  else {
    char *orgcmd = NULL;
    char *cmd = NULL;
    size_t cmdsize = 0;
    int num = 0;

    /* get the custom server control "commands" */
    error = getpart(&orgcmd, &cmdsize, "reply", "servercmd", stream);
    fclose(stream);
    if(error) {
      logmsg("getpart() failed with error: %d", error);
      return 1; /* done */
    }

    cmd = orgcmd;
    while(cmd && cmdsize) {
      char *check;
      if(1 == sscanf(cmd, "writedelay: %d", &num)) {
        logmsg("instructed to delay %d secs between packets", num);
        req->writedelay = num;
      }
      else {
        logmsg("Unknown <servercmd> instruction found: %s", cmd);
      }
      /* try to deal with CRLF or just LF */
      check = strchr(cmd, '\r');
      if(!check)
        check = strchr(cmd, '\n');

      if(check) {
        /* get to the letter following the newline */
        while((*check == '\r') || (*check == '\n'))
          check++;

        if(!*check)
          /* if we reached a zero, get out */
          break;
        cmd = check;
      }
      else
        break;
    }
    free(orgcmd);
  }

  return 0; /* OK! */
}


/*
 * Validate file access.
 */
static int validate_access(struct testcase *test,
                           const char *filename, int mode)
{
  char *ptr;
  long testno, partno;
  int error;
  char partbuf[80]="data";

  logmsg("trying to get file: %s mode %x", filename, mode);

  if(!strncmp("verifiedserver", filename, 14)) {
    char weare[128];
    size_t count = snprintf(weare, sizeof(weare),
                            "WE ROOLZ: %ld\r\n", (long)getpid());

    logmsg("Are-we-friendly question received");
    test->buffer = strdup(weare);
    test->rptr = test->buffer; /* set read pointer */
    test->bufsize = count;    /* set total count */
    test->rcount = count;     /* set data left to read */
    return 0; /* fine */
  }

  /* find the last slash */
  ptr = strrchr(filename, '/');

  if(ptr) {
    char *file;

    ptr++; /* skip the slash */

    /* skip all non-numericals following the slash */
    while(*ptr && !ISDIGIT(*ptr))
      ptr++;

    /* get the number */
    testno = strtol(ptr, &ptr, 10);

    if(testno > 10000) {
      partno = testno % 10000;
      testno /= 10000;
    }
    else
      partno = 0;


    logmsg("requested test number %ld part %ld", testno, partno);

    test->testno = testno;

    (void)parse_servercmd(test);

    file = test2file(testno);

    if(0 != partno)
      snprintf(partbuf, sizeof(partbuf), "data%ld", partno);

    if(file) {
      FILE *stream = fopen(file, "rb");
      if(!stream) {
        error = errno;
        logmsg("fopen() failed with error: %d %s", error, strerror(error));
        logmsg("Error opening file: %s", file);
        logmsg("Couldn't open test file: %s", file);
        return EACCESS;
      }
      else {
        size_t count;
        error = getpart(&test->buffer, &count, "reply", partbuf, stream);
        fclose(stream);
        if(error) {
          logmsg("getpart() failed with error: %d", error);
          return EACCESS;
        }
        if(test->buffer) {
          test->rptr = test->buffer; /* set read pointer */
          test->bufsize = count;    /* set total count */
          test->rcount = count;     /* set data left to read */
        }
        else
          return EACCESS;
      }

    }
    else
      return EACCESS;
  }
  else {
    logmsg("no slash found in path");
    return EACCESS; /* failure */
  }

  logmsg("file opened and all is good");
  return 0;
}

/*
 * Send the requested file.
 */
static void sendtftp(struct testcase *test, struct formats *pf)
{
  int size;
  ssize_t n;
  /* These are volatile to live through a siglongjmp */
  volatile unsigned short sendblock; /* block count */
  struct tftphdr * volatile sdp = r_init(); /* data buffer */
  struct tftphdr * const sap = &ackbuf.hdr; /* ack buffer */

  sendblock = 1;
#if defined(HAVE_ALARM) && defined(SIGALRM)
  mysignal(SIGALRM, timer);
#endif
  do {
    size = readit(test, (struct tftphdr **)&sdp, pf->f_convert);
    if(size < 0) {
      nak(errno + 100);
      return;
    }
    sdp->th_opcode = htons((unsigned short)opcode_DATA);
    sdp->th_block = htons(sendblock);
    timeout = 0;
#ifdef HAVE_SIGSETJMP
    (void) sigsetjmp(timeoutbuf, 1);
#endif
    if(test->writedelay) {
      logmsg("Pausing %d seconds before %d bytes", test->writedelay,
             size);
      wait_ms(1000*test->writedelay);
    }

    send_data:
    if(swrite(peer, sdp, size + 4) != size + 4) {
      logmsg("write");
      return;
    }
    read_ahead(test, pf->f_convert);
    for(;;) {
#ifdef HAVE_ALARM
      alarm(rexmtval);        /* read the ack */
#endif
      n = sread(peer, &ackbuf.storage[0], sizeof(ackbuf.storage));
#ifdef HAVE_ALARM
      alarm(0);
#endif
      if(got_exit_signal)
        return;
      if(n < 0) {
        logmsg("read: fail");
        return;
      }
      sap->th_opcode = ntohs((unsigned short)sap->th_opcode);
      sap->th_block = ntohs(sap->th_block);

      if(sap->th_opcode == opcode_ERROR) {
        logmsg("got ERROR");
        return;
      }

      if(sap->th_opcode == opcode_ACK) {
        if(sap->th_block == sendblock) {
          break;
        }
        /* Re-synchronize with the other side */
        (void) synchnet(peer);
        if(sap->th_block == (sendblock-1)) {
          goto send_data;
        }
      }

    }
    sendblock++;
  } while(size == SEGSIZE);
}

/*
 * Receive a file.
 */
static void recvtftp(struct testcase *test, struct formats *pf)
{
  ssize_t n, size;
  /* These are volatile to live through a siglongjmp */
  volatile unsigned short recvblock; /* block count */
  struct tftphdr * volatile rdp;     /* data buffer */
  struct tftphdr *rap;      /* ack buffer */

  recvblock = 0;
  rdp = w_init();
#if defined(HAVE_ALARM) && defined(SIGALRM)
  mysignal(SIGALRM, timer);
#endif
  rap = &ackbuf.hdr;
  do {
    timeout = 0;
    rap->th_opcode = htons((unsigned short)opcode_ACK);
    rap->th_block = htons(recvblock);
    recvblock++;
#ifdef HAVE_SIGSETJMP
    (void) sigsetjmp(timeoutbuf, 1);
#endif
send_ack:
    if(swrite(peer, &ackbuf.storage[0], 4) != 4) {
      logmsg("write: fail\n");
      goto abort;
    }
    write_behind(test, pf->f_convert);
    for(;;) {
#ifdef HAVE_ALARM
      alarm(rexmtval);
#endif
      n = sread(peer, rdp, PKTSIZE);
#ifdef HAVE_ALARM
      alarm(0);
#endif
      if(got_exit_signal)
        goto abort;
      if(n < 0) {                       /* really? */
        logmsg("read: fail\n");
        goto abort;
      }
      rdp->th_opcode = ntohs((unsigned short)rdp->th_opcode);
      rdp->th_block = ntohs(rdp->th_block);
      if(rdp->th_opcode == opcode_ERROR)
        goto abort;
      if(rdp->th_opcode == opcode_DATA) {
        if(rdp->th_block == recvblock) {
          break;                         /* normal */
        }
        /* Re-synchronize with the other side */
        (void) synchnet(peer);
        if(rdp->th_block == (recvblock-1))
          goto send_ack;                 /* rexmit */
      }
    }

    size = writeit(test, &rdp, (int)(n - 4), pf->f_convert);
    if(size != (n-4)) {                 /* ahem */
      if(size < 0)
        nak(errno + 100);
      else
        nak(ENOSPACE);
      goto abort;
    }
  } while(size == SEGSIZE);
  write_behind(test, pf->f_convert);

  rap->th_opcode = htons((unsigned short)opcode_ACK);  /* send the "final"
                                                          ack */
  rap->th_block = htons(recvblock);
  (void) swrite(peer, &ackbuf.storage[0], 4);
#if defined(HAVE_ALARM) && defined(SIGALRM)
  mysignal(SIGALRM, justtimeout);        /* just abort read on timeout */
  alarm(rexmtval);
#endif
  /* normally times out and quits */
  n = sread(peer, &buf.storage[0], sizeof(buf.storage));
#ifdef HAVE_ALARM
  alarm(0);
#endif
  if(got_exit_signal)
    goto abort;
  if(n >= 4 &&                               /* if read some data */
     rdp->th_opcode == opcode_DATA &&        /* and got a data block */
     recvblock == rdp->th_block) {           /* then my last ack was lost */
    (void) swrite(peer, &ackbuf.storage[0], 4);  /* resend final ack */
  }
abort:
  return;
}

/*
 * Send a nak packet (error message).  Error code passed in is one of the
 * standard TFTP codes, or a Unix errno offset by 100.
 */
static void nak(int error)
{
  struct tftphdr *tp;
  int length;
  struct errmsg *pe;

  tp = &buf.hdr;
  tp->th_opcode = htons((unsigned short)opcode_ERROR);
  tp->th_code = htons((unsigned short)error);
  for(pe = errmsgs; pe->e_code >= 0; pe++)
    if(pe->e_code == error)
      break;
  if(pe->e_code < 0) {
    pe->e_msg = strerror(error - 100);
    tp->th_code = EUNDEF;   /* set 'undef' errorcode */
  }
  length = (int)strlen(pe->e_msg);

  /* we use memcpy() instead of strcpy() in order to avoid buffer overflow
   * report from glibc with FORTIFY_SOURCE */
  memcpy(tp->th_msg, pe->e_msg, length + 1);
  length += 5;
  if(swrite(peer, &buf.storage[0], length) != length)
    logmsg("nak: fail\n");
}
