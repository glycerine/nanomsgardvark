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

# first start the tcpmux daemon
port = 5555
rc = nn.tcpmuxd(port)
if (rc < 0) {
  stop(paste("error trying to start tcpmuxd on port ", port, ":", nn.strerror()))
}

# Create a connection
sb = nn.socket(nn.AF_SP, nn.PAIR)
rc = nn.bind (sb, paste(sep="","tcpmux://*:",port,"/foo"))
if (rc < 0) {
  stop(paste("error trying to bind via tcpmuxd on port ", port, ":", nn.strerror()))
}

sc = nn.socket(nn.AF_SP, nn.PAIR) 
rc = nn.connect (sc, paste(sep="","tcpmux://127.0.0.1:",port,"/foo"))
if (rc < 0) {
  stop(paste("error trying to connect via tcpmuxd on port ", port, ":", nn.strerror()))
}

# Ping-pong test.
for (i in 0:100) {
    rc=nn.send (sc, "ABC")
    if (nn.is.send.err(rc)) {
      stop(paste("problem on send",i,":",nn.strerror()))
    }
    got=nn.recv(sb)
    if (got != "ABC") {
      stop(paste("problem on recv",i,":",nn.strerror()))
    }
}

# Cleanup.
nn.close(sc)
nn.close(sb)
}}
\keyword{utilities}
