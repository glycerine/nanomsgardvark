\name{nn.recv}
\alias{nn.recv}
\title{
Receive a message on a nanomsg socket (and optionally deserialize it
into an R object).
}
\description{

Receive a message from the socket 's'. nanomsgardvark uses the
underlying NN_MSG facility to ask nanomsg to allocate the appropriately
sized buffer for the incoming message. We then copy the bytes into an R
object and return the provided buffer with nn_freemsg().


The dont.wait argument specifies that the operation should be performed in non-blocking mode. If the
message cannot be received straight away, the function will fail with 'errno'
set to EAGAIN. Use nn.errno(), nn.strerror(), and nn.clearerr() to query
and clear the errno value between calls.

If the function succeeds the bytes of the message are returned (and
unserialized into an R object if unserialize=TRUE. Otherwise,
-1 is returned and 'errno' is set to to one of the values defined
below.

  
}
\usage{
nn.recv(socket, unserialize=TRUE, dont.wait=FALSE)
}

\arguments{
\item{socket}{a nanomsg socket object}
\item{unserialize}{whether to call unserialize on the received
  data. defaults to TRUE.}
\item{dont.wait}{defaults to FALSE, for blocking receive. Set to TRUE for non-blocking receive.}
}
\value{
If there is an error, then an integer is returned and the caller should
check nn.errno().

The helper function nn.is.recv.err() demonstrates
error detection. If dont.wait is TRUE and no message is available to
receive, the caller will get -1 returned, and nn.errno() will return
nn.EAGAIN. See the example code below.

On success, the returned value depends on the unserialize flag. If
unserialize is TRUE on success, then the returned value is the R object obtained by
calling unserialize(msg) on the received msg bytes.

If unserialize is FALSE, then the returned value is the RAWSXP byte
string received on the socket.

The possible errno values in case of error:

\item{EBADF}{The provided socket is invalid.}
\item{ENOTSUP}{The operation is not supported by this socket type.}
\item{EFSM}{The operation cannot be performed on this socket at the moment because socket is
not in the appropriate state.  This error may occur with socket types that
switch between several states.}
\item{EAGAIN}{Non-blocking mode was requested and there's no message to receive at the moment.}
\item{EINTR}{The operation was interrupted by delivery of a signal
  before the message was received.}
\item{ETIMEDOUT}{Individual socket types may define their own specific timeouts. If such timeout
is hit this error will be returned.}
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
  \code{\link{nn.connect},\link{nn.bind},\link{nn.recv},\link{nn.send}}
}
\examples{\dontrun{

###### Example 1: blocking receive

###### server code:

#!/usr/bin/env Rscript
library(nanomsgardvark)
s.rep <- nn.socket(nn.AF_SP, nn.REP)
nn.clearerr()
rc = nn.bind(s.rep,"tcp://*:5555")
if (nn.is.bind.err(rc)) {
   stop(paste("problem with nn.bind", nn.strerror()))
}
while(1) {
    nn.clearerr()
    msg = nn.recv(s.rep);
    if (nn.is.recv.err(msg)) {
       stop(paste("problem with nn.recv", nn.strerror()))
    }
    fun <- msg$fun
    args <- msg$args
    print(args)
    ans <- do.call(fun,args)
    nn.clearerr()
    rc = nn.send(s.rep,ans);
    if (nn.is.send.err(rc)) {
       stop(paste("problem with nn.send", nn.strerror()))
    }
}
# when you are done, remember to:
nn.close(s.rep)


###### blocking client code

library(nanomsgardvark)

remote.exec <- function(socket,fun,...) {
    rc = nn.send(socket,data=list(fun=fun,args=list(...)))
    nn.recv(socket)
}

s.req <- nn.socket(nn.AF_SP, nn.REQ)

nn.clearerr()
rc = nn.connect(s.req,"tcp://localhost:5555")
if (nn.is.connect.err(rc)) {
   stop(paste("problem with nn.connect", nn.strerror()))
}
ans <- remote.exec(s.req,sqrt,10000)

# when done, remember to
nn.close(s.req)


########## Example 2: non-blocking receive example


library(nanomsgardvark)

# nanomsg endpoint to use in tests cases.
test.ENDPOINT <- "inproc://poll"

#test.ENDPOINT <- "ipc:///tmp/test.ipc"
#test.ENDPOINT <- "tcp://127.0.0.1:5556"

# Testing helpers.
assert <- function(condition, message="Assertion Failed") if(!condition)
stop(message)
assert.fails <- function(expr, message="Assertion Failed") {
    result <- try(expr, TRUE)
    assert(inherits(result, 'try-error'), message)
}


# A basic test of poll functionality with nn.recv()
test.nanomsgardvark.poll.basic <- function() {
    s.rep <- nn.socket(nn.AF_SP, nn.REP)
    s.req <- nn.socket(nn.AF_SP, nn.REQ)

    rc = nn.bind(s.rep, test.ENDPOINT)
    assert(rc > 0, "nn.bind() should return positive endpoint id")

    rc = nn.connect(s.req, test.ENDPOINT)
    assert(rc > 0, "nn.connect() should return positive endpoint id")

    pollrc <- nn.recv(s.rep, unserialize=TRUE, dont.wait = TRUE)
    assert(pollrc == -1, "nn.recv() should return -1")
    assert(nn.strerror() == "Resource temporarily unavailable",
    "nn.strerror() should return 'Resource temporarily unavailable'")

    nn.clearerr()
    sendrc = nn.send(s.req, "Hello")
    assert(sendrc > 0, "nn.send('Hello') should return positive integer
    indicating success.")

    nn.clearerr()
    pollrc <- nn.recv(s.rep, unserialize=TRUE, dont.wait = TRUE)
    assert(pollrc == "Hello", "nn.recv() should return 'Hello'")

    # try again, this time nothing should be there
    nn.clearerr()
    pollrc <- nn.recv(s.rep, unserialize=TRUE, dont.wait = TRUE)
    assert(pollrc == -1, "nn.recv() should return -1")
    assert(nn.strerror() == "Resource temporarily unavailable",
    "nn.strerror() should return 'Resource temporarily unavailable'")

    rc = nn.close(s.rep)
    assert(rc == 0, "nn.close() should return 0")
    rc = nn.close(s.req)
    assert(rc == 0, "nn.close() should return 0")
}
# Run test
test.nanomsgardvark.poll.basic()


}}

\keyword{utilities}
