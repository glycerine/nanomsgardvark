\name{nn.send}
\alias{nn.send}
\alias{send.null.msg}
\alias{send.raw.string}
\title{
  send a message.
}
\description{
  Queue the message referenced by the msg argument to be sent to the socket referenced by the socket argument. 

  A successful invocation of nn.send does not indicate that the message has been transmitted to the network, only that it has been queued on the socket and ZMQ has assumed responsibility for the message.
}
\usage{
nn.send(socket, data, send.more=FALSE, serialize=TRUE)
send.null.msg(socket, send.more=FALSE)
send.raw.string(socket,data,send.more=FALSE)
}

\arguments{
  \item{socket}{a zmq socket object}
  \item{data}{the R object to be sent}
  \item{send.more}{whether this message has more frames to be sent}
  \item{serialize}{whether to call serialize before sending the data}
}
\value{
  a boolean indicating success or failure of the operation.
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

## remote execution server in nanomsgardvark
library(nanomsgardvark)
context = init.context()
in.socket = init.socket(context,"ZMQ_PULL")
nn.bind(in.socket,"tcp://*:5557")

out.socket = init.socket(context,"ZMQ_PUSH")
nn.bind(out.socket,"tcp://*:5558")

while(1) {
   msg = nn.recv(in.socket)
   fun <- msg$fun
   args <- msg$args
   print(args)
   ans <- do.call(fun,args)
   nn.send(out.socket,ans)
}
}}
\keyword{utilities}
