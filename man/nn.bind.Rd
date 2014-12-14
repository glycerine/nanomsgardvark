\name{nn.bind}
\alias{nn.bind}
\title{
Create an endpoint for accepting connections and bind it to the socket referenced by the socket argument.
}
\description{
Adds a local endpoint to the socket 's'. The endpoint can be then used by other
applications to connect to.

The 'addr' argument consists of two parts as follows: 'transport'`://`'address'.
The 'transport' specifies the underlying transport protocol to use. The meaning
of the 'address' part is specific to the underlying transport protocol.

For the list of available transport protocols check the list on
nanomsg manual page.

Maximum length of the 'addr' parameter is specified by nn.SOCKADDR_MAX.

Note that nn.bind() and nn.connect() may be called multiple times
on the same socket thus allowing the socket to communicate with multiple
heterogeneous endpoints.

RETURN VALUE
------------
If the function succeeds positive endpoint ID is returned. Endpoint ID can be
later used to remove the endpoint from the socket via nn.shutdown()
function.

If the function fails, then -1 is returned and nn.errno() returns one of
the values defined below.


ERRORS
------
*EBADF*::
The provided socket is invalid.
*EMFILE*::
Maximum number of active endpoints was reached.
*EINVAL*::
The syntax of the supplied address is invalid.
*ENAMETOOLONG*::
The supplied address is too long.
*EPROTONOSUPPORT*::
The requested transport protocol is not supported.
*EADDRNOTAVAIL*::
The requested endpoint is not local.
*ENODEV*::
Address specifies a nonexistent interface.
*EADDRINUSE*::
The requested local endpoint is already in use.
*ETERM*::
The library is terminating.

}
\usage{
nn.bind(socket, address)
}
\arguments{
  \item{socket}{a nanomsg socket object.}
  \item{address}{a transport as described above.}
}
\value{a positive endpoint ID is returned on success. On failure -1 is returned, and
you should check nn.errno() or nn.strerror().}
\references{
http://nanomsg.org
https://github.com/glycerine/rnanomsg
}
\author{
nanomsg was written by Martin Sustrik <sustrik@250bpm.com>.
rnanomsg was written by Jason E. Aten.
}


\seealso{
  \code{\link{nn.socket},\link{nn.connect},\link{nn.bind},\link{nn.recv},\link{nn.send}}
}
\examples{\dontrun{

library(rnanomsg)
in.socket = nn.socket(nn.AF_SP, nn.PULL)
rc = nn.bind(in.socket,"tcp://*:5557")
if (nn.is.bind.err(rc)) {
   stop(paste("problem with nn.bind", nn.strerror()))
}

out.socket = nn.socket(nn.AF_SP, nn.PUSH)
rc = nn.bind(out.socket,"tcp://*:5558")
if (nn.is.bind.err(rc)) {
   stop(paste("problem with nn.bind", nn.strerror()))
}

}}

\keyword{utilities}
