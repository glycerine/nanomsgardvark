###########################################################################
## Copyright (C) 2014  Jason E. Aten                                     ##
##  nanomsgardvark is derived from rzmq, which is                              ##
## Copyright (C) 2011  Whit Armstrong, and both are licensed             ##
##  under the GPL-3.                                                     ##
##                                                                       ##
## This program is free software: you can redistribute it and#or modify  ##
## it under the terms of the GNU General Public License as published by  ##
## the Free Software Foundation, either version 3 of the License, or     ##
## (at your option) any later version.                                   ##
##                                                                       ##
## This program is distributed in the hope that it will be useful,       ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         ##
## GNU General Public License for more details.                          ##
##                                                                       ##
## You should have received a copy of the GNU General Public License     ##
## along with this program.  If not, see <http:##www.gnu.org#licenses#>. ##
###########################################################################

nn.version <- function() {
    .Call("nnVersion", PACKAGE="nanomsgardvark")
}

nn.errno <- function() {
    .Call("nnErrno", PACKAGE="nanomsgardvark")
}

nn.clearerr <- function() {
  invisible(.Call("nnClearErrno", PACKAGE="nanomsgardvark"))
}

nn.strerror <- function() {
    .Call("nnStrerror", PACKAGE="nanomsgardvark")
}

nn.socket <- function(domain, socket.type) {
  .Call("nnSocket", domain, socket.type, PACKAGE="nanomsgardvark")
}  

nn.close <- function(socket) {
  invisible(.Call("nnClose", socket, PACKAGE="nanomsgardvark"))
}  

nn.term <- function() {
    .Call("nnTerm", PACKAGE="nanomsgardvark")
}

nn.bind <- function(socket, address) {
    invisible(.Call("nnBind", socket, address, PACKAGE="nanomsgardvark"))
}

nn.connect <- function(socket, address) {
    invisible(.Call("nnConnect", socket, address, PACKAGE="nanomsgardvark"))
}

nn.shutdown <- function(socket, how) {
    invisible(.Call("nnShutdown", socket, how, PACKAGE="nanomsgardvark"))
}

nn.getsockopt <- function(socket, level, option) {
    .Call("nnGetSockOpt", socket, level, option, PACKAGE="nanomsgardvark")
}

nn.setsockopt <- function(socket, level, option, optval) {
    invisible(.Call("nnSetSockOpt", socket, level, option, as.integer(optval), PACKAGE="nanomsgardvark"))
}

nn.send <- function(socket, data, dont.wait=FALSE, serialize=TRUE) {
    if(serialize) {
        data <- serialize(data,NULL)
    }

    invisible(.Call("nnSend", socket, data, dont.wait, PACKAGE="nanomsgardvark"))
}

nn.recv <- function(socket, unserialize=TRUE, dont.wait=FALSE) {
    ans <- .Call("nnRecv", socket, dont.wait, PACKAGE="nanomsgardvark")

    if (!is.null(ans) && is.integer(ans)) {
      # we get integers back on error, probably EAGAIN.
      return(ans)
    }

    # on success we can RAWSXP bytes back
    if(!is.null(ans) && unserialize) {
        ans <- unserialize(ans)
    }
    ans
}

# convenience function for checking if receive succeded or failed.
nn.is.recv.err <- function(ans) {
  if (!is.null(ans) && is.integer(ans)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

nn.is.send.err <- function(ans) {
  if (ans < 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

nn.is.connect.err <- function(ans) {
  if (ans < 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

nn.is.bind.err <- function(ans) {
  if (ans < 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# nn() simply looks up integer constants in the nanomsg library.
nn <- function(name) {
    .Call("nn", name, PACKAGE="nanomsgardvark")
}

# nn.genconst(): generate distinguished constants used by nanomsg
# For convenience, these are exported in the NAMESPACE and
#  defined below.
# This function allows you to confirm that those constants
#  are indeed up to date.
#
nn.genconst <- function() {
  clist = list(list("nn.NS_NAMESPACE","NN_NS_NAMESPACE"),
  list("nn.NS_VERSION","NN_NS_VERSION"),
  list("nn.NS_DOMAIN","NN_NS_DOMAIN"),
  list("nn.NS_TRANSPORT","NN_NS_TRANSPORT"),
  list("nn.NS_PROTOCOL","NN_NS_PROTOCOL"),
  list("nn.NS_OPTION_LEVEL","NN_NS_OPTION_LEVEL"),
  list("nn.NS_SOCKET_OPTION","NN_NS_SOCKET_OPTION"),
  list("nn.NS_TRANSPORT_OPTION","NN_NS_TRANSPORT_OPTION"),
  list("nn.NS_OPTION_TYPE","NN_NS_OPTION_TYPE"),
  list("nn.NS_FLAG","NN_NS_FLAG"),
  list("nn.NS_ERROR","NN_NS_ERROR"),
  list("nn.NS_LIMIT","NN_NS_LIMIT"),
  list("nn.TYPE_NONE","NN_TYPE_NONE"),
  list("nn.TYPE_INT","NN_TYPE_INT"),
  list("nn.TYPE_STR","NN_TYPE_STR"),
  list("nn.UNIT_NONE","NN_UNIT_NONE"),
  list("nn.UNIT_BYTES","NN_UNIT_BYTES"),
  list("nn.UNIT_MILLISECONDS","NN_UNIT_MILLISECONDS"),
  list("nn.UNIT_PRIORITY","NN_UNIT_PRIORITY"),
  list("nn.UNIT_BOOLEAN","NN_UNIT_BOOLEAN"),
  list("nn.VERSION_CURRENT","NN_VERSION_CURRENT"),
  list("nn.VERSION_REVISION","NN_VERSION_REVISION"),
  list("nn.VERSION_AGE","NN_VERSION_AGE"),
  list("nn.AF_SP","AF_SP"),
  list("nn.AF_SP_RAW","AF_SP_RAW"),
  list("nn.INPROC","NN_INPROC"),
  list("nn.IPC","NN_IPC"),
  list("nn.TCP","NN_TCP"),
  list("nn.PAIR","NN_PAIR"),
  list("nn.PUB","NN_PUB"),
  list("nn.SUB","NN_SUB"),
  list("nn.REP","NN_REP"),
  list("nn.REQ","NN_REQ"),
  list("nn.PUSH","NN_PUSH"),
  list("nn.PULL","NN_PULL"),
  list("nn.SURVEYOR","NN_SURVEYOR"),
  list("nn.RESPONDENT","NN_RESPONDENT"),
  list("nn.BUS","NN_BUS"),
  list("nn.SOCKADDR_MAX","NN_SOCKADDR_MAX"),
  list("nn.SOL_SOCKET","NN_SOL_SOCKET"),
  list("nn.LINGER","NN_LINGER"),
  list("nn.SNDBUF","NN_SNDBUF"),
  list("nn.RCVBUF","NN_RCVBUF"),
  list("nn.SNDTIMEO","NN_SNDTIMEO"),
  list("nn.RCVTIMEO","NN_RCVTIMEO"),
  list("nn.RECONNECT_IVL","NN_RECONNECT_IVL"),
  list("nn.RECONNECT_IVL_MAX","NN_RECONNECT_IVL_MAX"),
  list("nn.SNDPRIO","NN_SNDPRIO"),
  list("nn.SNDFD","NN_SNDFD"),
  list("nn.RCVFD","NN_RCVFD"),
  list("nn.DOMAIN","NN_DOMAIN"),
  list("nn.PROTOCOL","NN_PROTOCOL"),
  list("nn.IPV4ONLY","NN_IPV4ONLY"),
  list("nn.SOCKET_NAME","NN_SOCKET_NAME"),
  list("nn.SUB_SUBSCRIBE","NN_SUB_SUBSCRIBE"),
  list("nn.SUB_UNSUBSCRIBE","NN_SUB_UNSUBSCRIBE"),
  list("nn.REQ_RESEND_IVL","NN_REQ_RESEND_IVL"),
  list("nn.SURVEYOR_DEADLINE","NN_SURVEYOR_DEADLINE"),
  list("nn.TCP_NODELAY","NN_TCP_NODELAY"),
  list("nn.DONTWAIT","NN_DONTWAIT"),
  list("nn.EADDRINUSE","EADDRINUSE"),
  list("nn.EADDRNOTAVAIL","EADDRNOTAVAIL"),
  list("nn.EAFNOSUPPORT","EAFNOSUPPORT"),
  list("nn.EAGAIN","EAGAIN"),
  list("nn.EBADF","EBADF"),
  list("nn.ECONNREFUSED","ECONNREFUSED"),
  list("nn.EFAULT","EFAULT"),
  list("nn.EFSM","EFSM"),
  list("nn.EINPROGRESS","EINPROGRESS"),
  list("nn.EINTR","EINTR"),
  list("nn.EINVAL","EINVAL"),
  list("nn.EMFILE","EMFILE"),
  list("nn.ENAMETOOLONG","ENAMETOOLONG"),
  list("nn.ENETDOWN","ENETDOWN"),
  list("nn.ENOBUFS","ENOBUFS"),
  list("nn.ENODEV","ENODEV"),
  list("nn.ENOMEM","ENOMEM"),
  list("nn.ENOPROTOOPT","ENOPROTOOPT"),
  list("nn.ENOTSOCK","ENOTSOCK"),
  list("nn.ENOTSUP","ENOTSUP"),
  list("nn.EPROTO","EPROTO"),
  list("nn.EPROTONOSUPPORT","EPROTONOSUPPORT"),
  list("nn.ETERM","ETERM"),
  list("nn.ETIMEDOUT","ETIMEDOUT"),
  list("nn.EACCES","EACCES"),
  list("nn.ECONNABORTED","ECONNABORTED"),
  list("nn.ECONNRESET","ECONNRESET"),
  list("nn.EHOSTUNREACH","EHOSTUNREACH"),
  list("nn.EMSGSIZE","EMSGSIZE"),
  list("nn.ENETRESET","ENETRESET"),
  list("nn.ENETUNREACH","ENETUNREACH"),
  list("nn.ENOTCONN","ENOTCONN")
    )

  res = c()
  for (name in clist) {
       b = paste(name[[1]], " <- as.integer(", .Call("nn", name[[2]], PACKAGE="nanomsgardvark"), ")",sep="")
       res = c(res, b)
       eval.parent(parse(text=b))
  }
  invisible(res)
}    

  # distinguished constants used by nanomsg.
  # The list can be regenerated by calling nn.genconst().

  nn.NS_NAMESPACE <- as.integer(0)
  nn.NS_VERSION <- as.integer(1)
  nn.NS_DOMAIN <- as.integer(2)
  nn.NS_TRANSPORT <- as.integer(3)
  nn.NS_PROTOCOL <- as.integer(4)
  nn.NS_OPTION_LEVEL <- as.integer(5)
  nn.NS_SOCKET_OPTION <- as.integer(6)
  nn.NS_TRANSPORT_OPTION <- as.integer(7)
  nn.NS_OPTION_TYPE <- as.integer(8)
  nn.NS_FLAG <- as.integer(10)
  nn.NS_ERROR <- as.integer(11)
  nn.NS_LIMIT <- as.integer(12)
  nn.TYPE_NONE <- as.integer(0)
  nn.TYPE_INT <- as.integer(1)
  nn.TYPE_STR <- as.integer(2)
  nn.UNIT_NONE <- as.integer(0)
  nn.UNIT_BYTES <- as.integer(1)
  nn.UNIT_MILLISECONDS <- as.integer(2)
  nn.UNIT_PRIORITY <- as.integer(3)
  nn.UNIT_BOOLEAN <- as.integer(4)
  nn.VERSION_CURRENT <- as.integer(1)
  nn.VERSION_REVISION <- as.integer(0)
  nn.VERSION_AGE <- as.integer(1)
  nn.AF_SP <- as.integer(1)
  nn.AF_SP_RAW <- as.integer(2)
  nn.INPROC <- as.integer(-1)
  nn.IPC <- as.integer(-2)
  nn.TCP <- as.integer(-3)
  nn.PAIR <- as.integer(16)
  nn.PUB <- as.integer(32)
  nn.SUB <- as.integer(33)
  nn.REP <- as.integer(49)
  nn.REQ <- as.integer(48)
  nn.PUSH <- as.integer(80)
  nn.PULL <- as.integer(81)
  nn.SURVEYOR <- as.integer(96)
  nn.RESPONDENT <- as.integer(97)
  nn.BUS <- as.integer(112)
  nn.SOCKADDR_MAX <- as.integer(128)
  nn.SOL_SOCKET <- as.integer(0)
  nn.LINGER <- as.integer(1)
  nn.SNDBUF <- as.integer(2)
  nn.RCVBUF <- as.integer(3)
  nn.SNDTIMEO <- as.integer(4)
  nn.RCVTIMEO <- as.integer(5)
  nn.RECONNECT_IVL <- as.integer(6)
  nn.RECONNECT_IVL_MAX <- as.integer(7)
  nn.SNDPRIO <- as.integer(8)
  nn.SNDFD <- as.integer(10)
  nn.RCVFD <- as.integer(11)
  nn.DOMAIN <- as.integer(12)
  nn.PROTOCOL <- as.integer(13)
  nn.IPV4ONLY <- as.integer(14)
  nn.SOCKET_NAME <- as.integer(15)
  nn.SUB_SUBSCRIBE <- as.integer(1)
  nn.SUB_UNSUBSCRIBE <- as.integer(2)
  nn.REQ_RESEND_IVL <- as.integer(1)
  nn.SURVEYOR_DEADLINE <- as.integer(1)
  nn.TCP_NODELAY <- as.integer(1)
  nn.DONTWAIT <- as.integer(1)
  nn.EADDRINUSE <- as.integer(98)
  nn.EADDRNOTAVAIL <- as.integer(99)
  nn.EAFNOSUPPORT <- as.integer(97)
  nn.EAGAIN <- as.integer(11)
  nn.EBADF <- as.integer(9)
  nn.ECONNREFUSED <- as.integer(111)
  nn.EFAULT <- as.integer(14)
  nn.EFSM <- as.integer(156384766)
  nn.EINPROGRESS <- as.integer(115)
  nn.EINTR <- as.integer(4)
  nn.EINVAL <- as.integer(22)
  nn.EMFILE <- as.integer(24)
  nn.ENAMETOOLONG <- as.integer(36)
  nn.ENETDOWN <- as.integer(100)
  nn.ENOBUFS <- as.integer(105)
  nn.ENODEV <- as.integer(19)
  nn.ENOMEM <- as.integer(12)
  nn.ENOPROTOOPT <- as.integer(92)
  nn.ENOTSOCK <- as.integer(88)
  nn.ENOTSUP <- as.integer(95)
  nn.EPROTO <- as.integer(71)
  nn.EPROTONOSUPPORT <- as.integer(93)
  nn.ETERM <- as.integer(156384765)
  nn.ETIMEDOUT <- as.integer(110)
  nn.EACCES <- as.integer(13)
  nn.ECONNABORTED <- as.integer(103)
  nn.ECONNRESET <- as.integer(104)
  nn.EHOSTUNREACH <- as.integer(113)
  nn.EMSGSIZE <- as.integer(90)
  nn.ENETRESET <- as.integer(102)
  nn.ENETUNREACH <- as.integer(101)
  nn.ENOTCONN <- as.integer(107)
