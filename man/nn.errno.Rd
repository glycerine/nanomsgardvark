\name{nn.errno}
\alias{nn.errno}
\alias{nn.strerror}
\title{
  get libzmq error numbers and error strings
}
\description{
  return the error number or error description after a zmq call
}
\usage{
nn.errno()
nn.strerror()
}

\value{
  an integer for nn.errno or a string for nn.strerror
}
\references{
  http://www.zeromq.org
  http://api.zeromq.org
  http://zguide.zeromq.org/page:all
}
\author{
  ZMQ was written by Martin Sustrik <sustrik@250bpm.com> and Martin Lucina <mato@kotelna.sk>.
  nanomsgardvark was written by Whit Armstrong.
}

\seealso{
  \code{\link{nn.connect},\link{nn.bind},\link{nn.recv},\link{nn.send}}
}

\examples{\dontrun{

library(nanomsgardvark)
nn.errno()
nn.strerror()
}}
\keyword{utilities}
