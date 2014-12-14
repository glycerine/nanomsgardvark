\name{nn.version}
\alias{nn.version}
\title{
  get version of libnanomsg
}
\description{
  return the version string of the system nanomsg library
}
\usage{
nn.version()
}

\value{
  a string of the following format: NN_VERSION_CURRENT.NN_VERSION_REVISION
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
nn.version()

}}
\keyword{utilities}
