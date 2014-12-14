\name{nn.errno}
\alias{nn.errno}
\alias{nn.strerror}
\alias{nn.clearerr}
\title{
  get nanomsg error numbers and error strings
}
\description{
  nn.errno() returns the error number in the 
  global 'errno' value. Useful after a nanomsg (nanomsgardvark) call.

  nn.strerror() returns a string description of the value of errno.

  nn.clearerr() sets errno to 0.
}
\usage{
nn.errno()
nn.strerror()
nn.clearerr()
}

\value{
  an integer for nn.errno() or a string for nn.strerror(). nn_clearerr()
  returns null.
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
nn.errno()
nn.strerror()
nn.clearerr()
}}
\keyword{utilities}
