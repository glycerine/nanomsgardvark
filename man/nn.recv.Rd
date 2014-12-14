\name{nn.recv}
\alias{nn.recv}
\alias{receive.null.msg}
\alias{receive.string}
\alias{receive.int}
\alias{receive.double}
\title{
Receive a message from the socket referenced by the socket argument.
}
\description{
The zmq_recv() function shall receive a message from the socket
referenced by the socket argument. If there are no messages available
on the specified socket, by default the function shall block until the request
can be satisfied.
A non-blocking receive can be obtained by setting dont.wait to TRUE
If there are no messages available on the specified socket, the
nn.recv() call will return NULL immediately.

}
\usage{
nn.recv(socket, unserialize=TRUE, dont.wait=FALSE)
receive.null.msg(socket)
receive.string(socket)
receive.int(socket)
receive.double(socket)
}

\arguments{
\item{socket}{a zmq socket object}
\item{unserialize}{whether to call unserialize on the received data}
\item{dont.wait}{defaults to false, for blocking receive. Set to TRUE for non-blocking receive.}
}
\value{
  the value sent from the remote server or NULL on failure.
  If dont.wait was TRUE and a message was not immediately
  available for receipt, NULL is returned and get.nn[.]errno() is set to 11
  or get.nn[.]strerror() is set to EAGAIN.
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
  \code{\link{nn.connect},\link{nn.bind},\link{nn.recv},\link{nn.send},\l}
}
\examples{\dontrun{
library(nanomsgardvark)

remote.exec <- function(out.socket,in.socket,fun,...) {
    nn.send(out.socket,data=list(fun=fun,args=list(...)))
    nn.recv(in.socket)
}

context = init.context()
out.socket = init.socket(context,"ZMQ_PUSH")
nn.bind(out.socket,"tcp://*:5557")

in.socket = init.socket(context,"ZMQ_PULL")
nn.bind(in.socket,"tcp://*:5558")


myfun <- function(x) {
    sum(abs(x))
}

remote.exec(out.socket,in.socket,myfun,rnorm(1e3))

}}

\keyword{utilities}
