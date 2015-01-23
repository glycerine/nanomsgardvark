\name{nn.tcpmuxd}
\alias{nn.tcpmuxd}
\title{
  start a tcpmux daemon on the given tcp port number
}
\description{
  starts a nanomsg tcpmux daemon on the given port. A bind command like
  nn.bind (s, "tcpmux://*:5555/myservice"); and a connect command like
  nn.connect (s2, "tcpmux://127.0.0.1:5555/myservice"); should then succeed.
}
\usage{
rc = nn.tcpmuxd(port)
}

\value{
  an integer error code, 0 meaning success.
}
\references{
  http://nanomsg.org
}
\author{
nanomsg was written by Martin Sustrik <sustrik@250bpm.com>.
nanomsgardvark was written by Jason E. Aten.
}

\seealso{
  \code{\link{nn.connect},\link{nn.bind},\link{nn.recv},\link{nn.send}}
}

\examples{\dontrun{
library(nanomsgardvark)
port = 5555
rc = nn.tcpmuxd(port)
if (rc < 0) {
  stop(paste("error trying to start tcpmuxd on port ", port, ":", nn.strerror()))
}
}}
\keyword{utilities}
