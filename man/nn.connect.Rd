\name{nn.connect}
\alias{nn.connect}
\title{
add a remote endpoint to the socket.
}
\description{
  Adds a remote endpoint to the socket 's'. The library would then try to connect
to the specified remote endpoint.

The 'addr' argument consists of two parts as follows: 'transport'`://`'address'.
The 'transport' specifies the underlying transport protocol to use. The meaning
of the 'address' part is specific to the underlying transport protocol.

For the list of available transport protocols check the list on
nanomsg manual page.

Maximum length of the 'addr' parameter is specified by nn.SOCKADDR_MAX.

Note that nn.connect() and nn.bind() may be called multiple times
on the same socket thus allowing the socket to communicate with multiple
heterogeneous endpoints.

}
\usage{
nn.nn.connect, address)
}

\arguments{
  \item{socket}{a nanomsg socket object.}
  \item{address}{a transport://address string.}
}
\value{
If the function succeeds positive endpoint ID is returned. Endpoint ID can be
later used to remove the endpoint from the socket via linknanomsg:nn_shutdown[3]
function.

If the function fails negative value is returned and 'errno' is set to to one of
the values defined below.

\item{EBADF}{The provided socket is invalid.}
\item{EMFILE}{Maximum number of active endpoints was reached.}
\item{EINVAL}{The syntax of the supplied address is invalid.}
\item{ENAMETOOLONG}{The supplied address is too long.}
\item{EPROTONOSUPPORT}{The requested transport protocol is not supported.}
\item{ENODEV}{Address specifies a nonexistent interface.}
\item{ETERM}{The library is terminating.}

}
\references{
http://nanomsg.org
}
\author{
nanomsg was written by Martin Sustrik <sustrik@250bpm.com>.
nanomsgardvark was written by Jason E. Aten.
}
\seealso{
  \code{\link{nn.socket},\link{nn.connect},\link{nn.bind},\link{nn.recv},\link{nn.send}}
}
\examples{\dontrun{

library(nanomsgardvark)
s = nn.socket (nn.AF_SP, nn.NN_PUB);
eid1 = nn.connect(s, "ipc:///tmp/test.ipc");
eid2 = nn.connect(s, "tcp://server001:5560");

}}
\keyword{utilities}
