\name{nn.setsockopt}
\title{
  set a socket option.
}
\description{

  nn.setsockopt() sets the value of the 'option'. The 'level' argument specifies the protocol
level at which the option resides. For generic socket-level options use
nn.SOL_SOCKET level. For socket-type-specific options use socket type
for 'level' argument (e.g. nn.SUB). For transport-specific options use ID of
the transport as the 'level' argument (e.g. nn.TCP).

The new value is pointed to by 'optval' argument. Size of the option is
specified by the 'optvallen' argument.

The optval must be an integer, see the definitions in the nn.R file of
the nanomsgardvark package. The NN_SOCKET_NAME
option (that passes in a string value via optval) is not supported in nanomsgardvark.

<nanomsg/nn.h> header defines generic socket-level options
(nn.SOL_SOCKET level). The options are as follows:

\item{nn.LINGER}{    Specifies how long should the socket try to send pending outbound messages
    after nn.close() have been called, in milliseconds. Negative value means
    infinite linger. The type of the option is int. Default value
    is 1000 (1 second).}
\item{nn.SNDBUF}{    Size of the send buffer, in bytes. To prevent blocking for messages larger
    than the buffer, exactly one message may be buffered in addition to the data
    in the send buffer. The type of this option is int. Default value is 128kB.}
\item{nn.RCVBUF}{    Size of the receive buffer, in bytes. To prevent blocking for messages
    larger than the buffer, exactly one message may be buffered in addition
    to the data in the receive buffer. The type of this option is int. Default
    value is 128kB.}
\item{nn.SNDTIMEO}{    The timeout for send operation on the socket, in milliseconds. If message
    cannot be sent within the specified timeout, EAGAIN error is returned.
    Negative value means infinite timeout. The type of the option is int.
    Default value is -1.}
\item{nn.RCVTIMEO}{    The timeout for recv operation on the socket, in milliseconds. If message
    cannot be received within the specified timeout, EAGAIN error is returned.
    Negative value means infinite timeout. The type of the option is int.
    Default value is -1.}
\item{nn.RECONNECT_IVL}{    For connection-based transports such as TCP, this option specifies how
    long to wait, in milliseconds, when connection is broken before trying
    to re-establish it. Note that actual reconnect interval may be randomised
    to some extent to prevent severe reconnection storms. The type of the option
    is int. Default value is 100 (0.1 second).}
\item{nn.RECONNECT_IVL_MAX}{    This option is to be used only in addition to nn.RECONNECT_IVL option.
    It specifies maximum reconnection interval. On each reconnect attempt,
    the previous interval is doubled until nn.RECONNECT_IVL_MAX is reached.
    Value of zero means that no exponential backoff is performed and reconnect
    interval is based only on nn.RECONNECT_IVL. If nn.RECONNECT_IVL_MAX is
    less than nn.RECONNECT_IVL, it is ignored. The type of the option is int.
    Default value is 0.}
\item{nn.SNDPRIO}{    Sets outbound priority for endpoints subsequently added to the socket. This
    option has no effect on socket types that send messages to all the peers.
    However, if the socket type sends each message to a single peer
    (or a limited set of peers), peers with high priority take precedence
    over peers with low priority. The type of the option is int. Highest
    priority is 1, lowest priority is 16. Default value is 8.}
\item{nn.RCVPRIO}{    Sets inbound priority for endpoints subsequently added to the socket. This
    option has no effect on socket types that are not able to receive messages.
    When receiving a message, messages from peer with higher priority are
    received before messages from peer with lower priority. The type of the
    option is int. Highest priority is 1, lowest priority is 16. Default value
    is 8.}
\item{nn.IPV4ONLY}{    If set to 1, only IPv4 addresses are used. If set to 0, both IPv4 and IPv6
    addresses are used. The type of the option is int. Default value is 1.}

}
\usage{
nn.setsockopt(socket, level, option, optval)
}

\arguments{
  \item{socket}{a nanomsg socket object}
  \item{level}{the protocol level at which the option resides}
  \item{option}{name of the option to modify}
  \item{optval}{the new option value to be set}
}
\value{
  If the function succeeds zero is returned. Otherwise, -1 is
returned and 'errno' is set to to one of the values defined below.

\item{EBADF}{The provided socket is invalid.}
\item{ENOPROTOOPT}{The option is unknown at the level indicated.}
\item{EINVAL}{The specified option value is invalid.}
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

library(nanomsgardvark)
socket = nn.socket(nn.AF_SP, nn.REQ)

set.hwm(socket, 1L)
set.swap(socket, 100L)
set.identity(socket, "big.socket")
}}
\keyword{utilities}
