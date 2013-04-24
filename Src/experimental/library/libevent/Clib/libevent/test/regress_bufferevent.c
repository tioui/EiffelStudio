/*
 * Copyright (c) 2003-2007 Niels Provos <provos@citi.umich.edu>
 * Copyright (c) 2007-2009 Niels Provos and Nick Mathewson
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif

#include "event-config.h"

#include <sys/types.h>
#include <sys/stat.h>
#ifdef _EVENT_HAVE_SYS_TIME_H
#include <sys/time.h>
#endif
#include <sys/queue.h>
#ifndef WIN32
#include <sys/socket.h>
#include <sys/wait.h>
#include <signal.h>
#include <unistd.h>
#include <netdb.h>
#include <netinet/in.h>
#endif
#include <fcntl.h>
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <assert.h>

#ifdef _EVENT_HAVE_ARPA_INET_H
#include <arpa/inet.h>
#endif

#include "event-config.h"
#include "event2/event.h"
#include "event2/event_struct.h"
#include "event2/event_compat.h"
#include "event2/tag.h"
#include "event2/buffer.h"
#include "event2/bufferevent.h"
#include "event2/bufferevent_compat.h"
#include "event2/bufferevent_struct.h"
#include "event2/listener.h"
#include "event2/util.h"

#include "bufferevent-internal.h"
#ifdef WIN32
#include "iocp-internal.h"
#endif

#include "regress.h"

/*
 * simple bufferevent test
 */

static void
readcb(struct bufferevent *bev, void *arg)
{
	if (evbuffer_get_length(bev->input) == 8333) {
		struct evbuffer *evbuf = evbuffer_new();
		assert(evbuf != NULL);

		/* gratuitous test of bufferevent_read_buffer */
		bufferevent_read_buffer(bev, evbuf);

		bufferevent_disable(bev, EV_READ);

		if (evbuffer_get_length(evbuf) == 8333) {
			test_ok++;
                }

		evbuffer_free(evbuf);
	}
}

static void
writecb(struct bufferevent *bev, void *arg)
{
	if (evbuffer_get_length(bev->output) == 0) {
		test_ok++;
        }
}

static void
errorcb(struct bufferevent *bev, short what, void *arg)
{
	test_ok = -2;
}

static void
test_bufferevent_impl(int use_pair)
{
	struct bufferevent *bev1 = NULL, *bev2 = NULL;
	char buffer[8333];
	int i;

	if (use_pair) {
		struct bufferevent *pair[2];
		tt_assert(0 == bufferevent_pair_new(NULL, 0, pair));
		bev1 = pair[0];
		bev2 = pair[1];
		bufferevent_setcb(bev1, readcb, writecb, errorcb, NULL);
		bufferevent_setcb(bev2, readcb, writecb, errorcb, NULL);
		tt_int_op(bufferevent_getfd(bev1), ==, -1);
		tt_ptr_op(bufferevent_get_underlying(bev1), ==, NULL);
	} else {
		bev1 = bufferevent_new(pair[0], readcb, writecb, errorcb, NULL);
		bev2 = bufferevent_new(pair[1], readcb, writecb, errorcb, NULL);
		tt_int_op(bufferevent_getfd(bev1), ==, pair[0]);
		tt_ptr_op(bufferevent_get_underlying(bev1), ==, NULL);
	}

	bufferevent_disable(bev1, EV_READ);
	bufferevent_enable(bev2, EV_READ);

	tt_int_op(bufferevent_get_enabled(bev1), ==, EV_WRITE);
	tt_int_op(bufferevent_get_enabled(bev2), ==, EV_WRITE|EV_READ);

	for (i = 0; i < sizeof(buffer); i++)
		buffer[i] = i;

	bufferevent_write(bev1, buffer, sizeof(buffer));

	event_dispatch();

	bufferevent_free(bev1);
	bufferevent_free(bev2);

	if (test_ok != 2)
		test_ok = 0;
end:
	;
}

static void
test_bufferevent(void)
{
	test_bufferevent_impl(0);
}

static void
test_bufferevent_pair(void)
{
	test_bufferevent_impl(1);
}

/*
 * test watermarks and bufferevent
 */

static void
wm_readcb(struct bufferevent *bev, void *arg)
{
	struct evbuffer *evbuf = evbuffer_new();
	int len = evbuffer_get_length(bev->input);
	static int nread;

	assert(len >= 10 && len <= 20);

	assert(evbuf != NULL);

	/* gratuitous test of bufferevent_read_buffer */
	bufferevent_read_buffer(bev, evbuf);

	nread += len;
	if (nread == 65000) {
		bufferevent_disable(bev, EV_READ);
		test_ok++;
	}

	evbuffer_free(evbuf);
}

static void
wm_writecb(struct bufferevent *bev, void *arg)
{
        assert(evbuffer_get_length(bev->output) <= 100);
	if (evbuffer_get_length(bev->output) == 0) {
                evbuffer_drain(bev->output, evbuffer_get_length(bev->output));
		test_ok++;
        }
}

static void
wm_errorcb(struct bufferevent *bev, short what, void *arg)
{
	test_ok = -2;
}

static void
test_bufferevent_watermarks_impl(int use_pair)
{
	struct bufferevent *bev1 = NULL, *bev2 = NULL;
	char buffer[65000];
	int i;
	test_ok = 0;

	if (use_pair) {
		struct bufferevent *pair[2];
		tt_assert(0 == bufferevent_pair_new(NULL, 0, pair));
		bev1 = pair[0];
		bev2 = pair[1];
		bufferevent_setcb(bev1, NULL, wm_writecb, errorcb, NULL);
		bufferevent_setcb(bev2, wm_readcb, NULL, errorcb, NULL);
	} else {
		bev1 = bufferevent_new(pair[0], NULL, wm_writecb, wm_errorcb, NULL);
		bev2 = bufferevent_new(pair[1], wm_readcb, NULL, wm_errorcb, NULL);
	}
	bufferevent_disable(bev1, EV_READ);
	bufferevent_enable(bev2, EV_READ);

	for (i = 0; i < sizeof(buffer); i++)
		buffer[i] = (char)i;

	/* limit the reading on the receiving bufferevent */
	bufferevent_setwatermark(bev2, EV_READ, 10, 20);

        /* Tell the sending bufferevent not to notify us till it's down to
           100 bytes. */
        bufferevent_setwatermark(bev1, EV_WRITE, 100, 2000);

	bufferevent_write(bev1, buffer, sizeof(buffer));

	event_dispatch();

	tt_int_op(test_ok, ==, 2);

        /* The write callback drained all the data from outbuf, so we
         * should have removed the write event... */
        tt_assert(!event_pending(&bev2->ev_write, EV_WRITE, NULL));

end:
	bufferevent_free(bev1);
	bufferevent_free(bev2);
}

static void
test_bufferevent_watermarks(void)
{
	test_bufferevent_watermarks_impl(0);
}

static void
test_bufferevent_pair_watermarks(void)
{
	test_bufferevent_watermarks_impl(1);
}

/*
 * Test bufferevent filters
 */

/* strip an 'x' from each byte */

static enum bufferevent_filter_result
bufferevent_input_filter(struct evbuffer *src, struct evbuffer *dst,
    ev_ssize_t lim, enum bufferevent_flush_mode state, void *ctx)
{
	const unsigned char *buffer;
	unsigned i;

	buffer = evbuffer_pullup(src, evbuffer_get_length(src));
	for (i = 0; i < evbuffer_get_length(src); i += 2) {
		assert(buffer[i] == 'x');
		evbuffer_add(dst, buffer + i + 1, 1);

		if (i + 2 > evbuffer_get_length(src))
			break;
	}

	evbuffer_drain(src, i);
	return (BEV_OK);
}

/* add an 'x' before each byte */

static enum bufferevent_filter_result
bufferevent_output_filter(struct evbuffer *src, struct evbuffer *dst,
    ev_ssize_t lim, enum bufferevent_flush_mode state, void *ctx)
{
	const unsigned char *buffer;
	unsigned i;

	buffer = evbuffer_pullup(src, evbuffer_get_length(src));
	for (i = 0; i < evbuffer_get_length(src); ++i) {
		evbuffer_add(dst, "x", 1);
		evbuffer_add(dst, buffer + i, 1);
	}

	evbuffer_drain(src, evbuffer_get_length(src));
	return (BEV_OK);
}


static void
test_bufferevent_filters_impl(int use_pair)
{
	struct bufferevent *bev1 = NULL, *bev2 = NULL;
	struct bufferevent *bev1_base = NULL, *bev2_base = NULL;
	char buffer[8333];
	int i;

        test_ok = 0;

	if (use_pair) {
		struct bufferevent *pair[2];
		tt_assert(0 == bufferevent_pair_new(NULL, 0, pair));
		bev1 = pair[0];
		bev2 = pair[1];
	} else {
		bev1 = bufferevent_socket_new(NULL, pair[0], 0);
		bev2 = bufferevent_socket_new(NULL, pair[1], 0);
	}
	bev1_base = bev1;
	bev2_base = bev2;

	for (i = 0; i < sizeof(buffer); i++)
		buffer[i] = i;

	bev1 = bufferevent_filter_new(bev1, NULL, bufferevent_output_filter,
				      0, NULL, NULL);

	bev2 = bufferevent_filter_new(bev2, bufferevent_input_filter,
				      NULL, 0, NULL, NULL);
	bufferevent_setcb(bev1, NULL, writecb, errorcb, NULL);
	bufferevent_setcb(bev2, readcb, NULL, errorcb, NULL);

	tt_ptr_op(bufferevent_get_underlying(bev1), ==, bev1_base);
	tt_ptr_op(bufferevent_get_underlying(bev2), ==, bev2_base);
	tt_int_op(bufferevent_getfd(bev1), ==, -1);
	tt_int_op(bufferevent_getfd(bev2), ==, -1);

	bufferevent_disable(bev1, EV_READ);
	bufferevent_enable(bev2, EV_READ);
	/* insert some filters */
	bufferevent_write(bev1, buffer, sizeof(buffer));

	event_dispatch();

	if (test_ok != 2)
		test_ok = 0;

end:
	bufferevent_free(bev1);
	bufferevent_free(bev2);

}

static void
test_bufferevent_filters(void)
{
	test_bufferevent_filters_impl(0);
}

static void
test_bufferevent_pair_filters(void)
{
	test_bufferevent_filters_impl(1);
}


static void
sender_writecb(struct bufferevent *bev, void *ctx)
{
	if (evbuffer_get_length(bufferevent_get_output(bev)) == 0) {
		bufferevent_disable(bev,EV_READ|EV_WRITE);
		bufferevent_free(bev);
	}
}

static void
sender_errorcb(struct bufferevent *bev, short what, void *ctx)
{
	TT_FAIL(("Got sender error %d",(int)what));
}

static int n_strings_read = 0;

#define TEST_STR "Now is the time for all good events to signal for " \
	"the good of their protocol"
static void
listen_cb(struct evconnlistener *listener, evutil_socket_t fd,
    struct sockaddr *sa, int socklen, void *arg)
{
	struct event_base *base = arg;
	struct bufferevent *bev;
	const char s[] = TEST_STR;
	TT_BLATHER(("Got a request on socket %d", (int)fd ));
	bev = bufferevent_socket_new(base, fd, BEV_OPT_CLOSE_ON_FREE);
	tt_assert(bev);
	bufferevent_write(bev, s, sizeof(s));
	bufferevent_setcb(bev, NULL, sender_writecb, sender_errorcb, NULL);
	bufferevent_enable(bev, EV_WRITE);
end:
	;
}

static void
reader_eventcb(struct bufferevent *bev, short what, void *ctx)
{
	struct event_base *base = ctx;
	if (what & BEV_EVENT_ERROR) {
		perror("foobar");
		TT_FAIL(("got connector error %d", (int)what));
		return;
	}
	if (what & BEV_EVENT_CONNECTED) {
		bufferevent_enable(bev, EV_READ);
	}
	if (what & BEV_EVENT_EOF) {
		char buf[512];
		size_t n;
		n = bufferevent_read(bev, buf, sizeof(buf)-1);
		buf[n] = '\0';
		tt_str_op(buf, ==, TEST_STR);
		if (++n_strings_read == 2)
			event_base_loopexit(base, NULL);
	}
end:
	;
}

static void
test_bufferevent_connect(void *arg)
{
	struct basic_test_data *data = arg;
	struct evconnlistener *lev=NULL;
	struct bufferevent *bev1=NULL, *bev2=NULL;
	struct sockaddr_in localhost;
	struct sockaddr *sa = (struct sockaddr*)&localhost;
	int be_flags=BEV_OPT_CLOSE_ON_FREE;

	if (strstr((char*)data->setup_data, "defer")) {
		be_flags |= BEV_OPT_DEFER_CALLBACKS;
	}
	if (strstr((char*)data->setup_data, "lock")) {
		be_flags |= BEV_OPT_THREADSAFE;
	}
#ifdef WIN32
	if (!strcmp((char*)data->setup_data, "unset_connectex")) {
		struct win32_extension_fns *ext =
	            (struct win32_extension_fns *)
		    event_get_win32_extension_fns();
		ext->ConnectEx = NULL;
	}
#endif

	memset(&localhost, 0, sizeof(localhost));

	localhost.sin_port = htons(27015);
	localhost.sin_addr.s_addr = htonl(0x7f000001L);
	localhost.sin_family = AF_INET;

	lev = evconnlistener_new_bind(data->base, listen_cb, data->base,
	    LEV_OPT_CLOSE_ON_FREE|LEV_OPT_REUSEABLE,
	    16, sa, sizeof(localhost));
	tt_assert(lev);
	tt_assert(!evconnlistener_enable(lev));
	bev1 = bufferevent_socket_new(data->base, -1, be_flags);
	bev2 = bufferevent_socket_new(data->base, -1, be_flags);
	tt_assert(bev1);
	tt_assert(bev2);
	bufferevent_setcb(bev1, NULL, NULL, reader_eventcb, data->base);
	bufferevent_setcb(bev2, NULL, NULL, reader_eventcb, data->base);

	tt_want(!bufferevent_socket_connect(bev1, sa, sizeof(localhost)));
	tt_want(!bufferevent_socket_connect(bev2, sa, sizeof(localhost)));

	bufferevent_enable(bev1, EV_READ);
	bufferevent_enable(bev2, EV_READ);

#ifdef WIN32
	/* FIXME this is to get IOCP to work. it shouldn't be required. */
	{
		struct timeval tv = {5000,0};
		event_base_loopexit(data->base, &tv);
	}
#endif
	event_base_dispatch(data->base);

	tt_int_op(n_strings_read, ==, 2);
end:
	if (lev)
		evconnlistener_free(lev);

	if (bev1)
		bufferevent_free(bev1);

	if (bev2)
		bufferevent_free(bev2);
}

static void
want_fail_eventcb(struct bufferevent *bev, short what, void *ctx)
{
	struct event_base *base = ctx;
	const char *err;
	evutil_socket_t s;

	if (what & BEV_EVENT_ERROR) {
		s = bufferevent_getfd(bev);
		err = evutil_socket_error_to_string(evutil_socket_geterror(s));
		TT_BLATHER(("connection failure %s", err));
		test_ok = 1;
	} else {
		TT_FAIL(("didn't fail? what %hd", what));
	}

	event_base_loopexit(base, NULL);
}

static void
close_socket_cb(evutil_socket_t fd, short what, void *arg)
{
	evutil_socket_t *fdp = arg;
	if (*fdp >= 0) {
		EVUTIL_CLOSESOCKET(*fdp);
		*fdp = -1;
	}
}

static void
test_bufferevent_connect_fail(void *arg)
{
	struct basic_test_data *data = arg;
	struct bufferevent *bev=NULL;
	struct sockaddr_in localhost;
	struct sockaddr *sa = (struct sockaddr*)&localhost;
	evutil_socket_t fake_listener = -1;
	ev_socklen_t slen = sizeof(localhost);
	struct event close_listener_event;
	int close_listener_event_added = 0;
	struct timeval one_second = { 1, 0 };
	int r;

	test_ok = 0;

	memset(&localhost, 0, sizeof(localhost));
	localhost.sin_port = 0;
	localhost.sin_addr.s_addr = htonl(0x7f000001L);
	localhost.sin_family = AF_INET;

	/* bind, but don't listen or accept. should trigger
	   "Connection refused" reliably on most platforms. */
	fake_listener = socket(localhost.sin_family, SOCK_STREAM, 0);
	tt_assert(fake_listener >= 0);
	tt_assert(bind(fake_listener, sa, slen) == 0);
	tt_assert(getsockname(fake_listener, sa, &slen) == 0);
	bev = bufferevent_socket_new(data->base, -1,
		BEV_OPT_CLOSE_ON_FREE | BEV_OPT_DEFER_CALLBACKS);
	tt_assert(bev);
	bufferevent_setcb(bev, NULL, NULL, want_fail_eventcb, data->base);

	r = bufferevent_socket_connect(bev, sa, slen);
	/* XXXX we'd like to test the '0' case everywhere, but FreeBSD tells
	 * detects the error immediately, which is not really wrong of it. */
	tt_want(r == 0 || r == -1);

	/* Close the listener socket after a second. This should trigger
	   "connection refused" on some other platforms, including OSX. */
	evtimer_assign(&close_listener_event, data->base, close_socket_cb,
	    &fake_listener);
	event_add(&close_listener_event, &one_second);
	close_listener_event_added = 1;

#ifdef WIN32
	/* FIXME this is to get IOCP to work. it shouldn't be required. */
	{
		struct timeval tv = {5000,0};
		event_base_loopexit(data->base, &tv);
	}
#endif
	event_base_dispatch(data->base);

	tt_int_op(test_ok, ==, 1);

end:
	if (fake_listener >= 0)
		EVUTIL_CLOSESOCKET(fake_listener);

	if (bev)
		bufferevent_free(bev);

	if (close_listener_event_added)
		event_del(&close_listener_event);
}

struct testcase_t bufferevent_testcases[] = {

        LEGACY(bufferevent, TT_ISOLATED),
        LEGACY(bufferevent_pair, TT_ISOLATED),
        LEGACY(bufferevent_watermarks, TT_ISOLATED),
        LEGACY(bufferevent_pair_watermarks, TT_ISOLATED),
        LEGACY(bufferevent_filters, TT_ISOLATED),
        LEGACY(bufferevent_pair_filters, TT_ISOLATED),
	{ "bufferevent_connect", test_bufferevent_connect, TT_FORK|TT_NEED_BASE,
	  &basic_setup, (void*)"" },
	{ "bufferevent_connect_defer", test_bufferevent_connect,
	  TT_FORK|TT_NEED_BASE, &basic_setup, (void*)"defer" },
	{ "bufferevent_connect_lock", test_bufferevent_connect,
	  TT_FORK|TT_NEED_BASE|TT_NEED_THREADS, &basic_setup, (void*)"lock" },
	{ "bufferevent_connect_lock_defer", test_bufferevent_connect,
	  TT_FORK|TT_NEED_BASE|TT_NEED_THREADS, &basic_setup,
	  (void*)"defer lock" },
	{ "bufferevent_connect_fail", test_bufferevent_connect_fail,
	  TT_FORK|TT_NEED_BASE, &basic_setup, NULL },
#ifdef _EVENT_HAVE_LIBZ
        LEGACY(bufferevent_zlib, TT_ISOLATED),
#else
        { "bufferevent_zlib", NULL, TT_SKIP, NULL, NULL },
#endif

        END_OF_TESTCASES,
};

struct testcase_t bufferevent_iocp_testcases[] = {

        LEGACY(bufferevent, TT_ISOLATED|TT_ENABLE_IOCP),
        LEGACY(bufferevent_watermarks, TT_ISOLATED|TT_ENABLE_IOCP),
        LEGACY(bufferevent_filters, TT_ISOLATED|TT_ENABLE_IOCP),
	{ "bufferevent_connect", test_bufferevent_connect,
	  TT_FORK|TT_NEED_BASE|TT_ENABLE_IOCP, &basic_setup, (void*)"" },
	{ "bufferevent_connect_defer", test_bufferevent_connect,
	  TT_FORK|TT_NEED_BASE|TT_ENABLE_IOCP, &basic_setup, (void*)"defer" },
	{ "bufferevent_connect_lock", test_bufferevent_connect,
	  TT_FORK|TT_NEED_BASE|TT_NEED_THREADS|TT_ENABLE_IOCP, &basic_setup,
	  (void*)"lock" },
	{ "bufferevent_connect_lock_defer", test_bufferevent_connect,
	  TT_FORK|TT_NEED_BASE|TT_NEED_THREADS|TT_ENABLE_IOCP, &basic_setup,
	  (void*)"defer lock" },
	{ "bufferevent_connect_fail", test_bufferevent_connect_fail,
	  TT_FORK|TT_NEED_BASE|TT_ENABLE_IOCP, &basic_setup, NULL },
	{ "bufferevent_connect_nonblocking", test_bufferevent_connect,
	  TT_FORK|TT_NEED_BASE|TT_ENABLE_IOCP, &basic_setup,
	  (void*)"unset_connectex" },

        END_OF_TESTCASES,
};
