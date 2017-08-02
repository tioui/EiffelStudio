Short: E
Long: cert
Arg: <certificate[:password]>
Help: Client certificate file and password
Protocols: TLS
See-also: cert-type key key-type
---
Tells curl to use the specified client certificate file when getting a file
with HTTPS, FTPS or another SSL-based protocol. The certificate must be in
PKCS#12 format if using Secure Transport, or PEM format if using any other
engine.  If the optional password isn't specified, it will be queried for on
the terminal. Note that this option assumes a \&"certificate" file that is the
private key and the client certificate concatenated! See --cert and --key to
specify them independently.

If curl is built against the NSS SSL library then this option can tell
curl the nickname of the certificate to use within the NSS database defined
by the environment variable SSL_DIR (or by default /etc/pki/nssdb). If the
NSS PEM PKCS#11 module (libnsspem.so) is available then PEM files may be
loaded. If you want to use a file from the current directory, please precede
it with "./" prefix, in order to avoid confusion with a nickname.  If the
nickname contains ":", it needs to be preceded by "\\" so that it is not
recognized as password delimiter.  If the nickname contains "\\", it needs to
be escaped as "\\\\" so that it is not recognized as an escape character.

(iOS and macOS only) If curl is built against Secure Transport, then the
certificate string can either be the name of a certificate/private key in the
system or user keychain, or the path to a PKCS#12-encoded certificate and
private key. If you want to use a file from the current directory, please
precede it with "./" prefix, in order to avoid confusion with a nickname.

If this option is used several times, the last one will be used.
