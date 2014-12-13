###########################################################################
## Copyright (C) 2014  Jason E. Aten                                     ##
##  rnanomsg is derived from rzmq, which is                              ##
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

nn <- function(name) {
    .Call("nn", name, PACKAGE="rnanomsg")
}

nn.version <- function() {
    .Call("nnVersion", PACKAGE="rnanomsg")
}

nn.errno <- function() {
    .Call("nnErrno", PACKAGE="rnanomsg")
}

nn.strerror <- function() {
    .Call("nnStrerror", PACKAGE="rnanomsg")
}

nn.socket <- function(domain, socket.type) {
  .Call("nnSocket", domain, socket.type, PACKAGE="rnanomsg")
}  

nn.close <- function(socket) {
  .Call("nnClose", socket, PACKAGE="rnanomsg")
}  

nn.term <- function() {
    .Call("nnTerm", PACKAGE="rnanomsg")
}

nn.bind <- function(socket, address) {
    invisible(.Call("nnBind", socket, address, PACKAGE="rnanomsg"))
}

nn.connect <- function(socket, address) {
    invisible(.Call("nnConnect", socket, address, PACKAGE="rnanomsg"))
}

nn.shutdown <- function(socket, how) {
    invisible(.Call("nnShutdown", socket, how, PACKAGE="rnanomsg"))
}

nn.getsockopt <- function(socket, level, option) {
    invisible(.Call("nnGetSockOpt", socket, level, option, PACKAGE="rnanomsg"))
}

nn.setsockopt <- function(socket, level, option, optval) {
    invisible(.Call("nnSetSockOpt", socket, level, option, optval, PACKAGE="rnanomsg"))
}

nn.send <- function(socket, data, send.more=FALSE, serialize=TRUE) {
    if(serialize) {
        data <- serialize(data,NULL)
    }

    invisible(.Call("sendSocket", socket, data, send.more, PACKAGE="rnanomsg"))
}

nn.recv <- function(socket, unserialize=TRUE, dont.wait=FALSE) {
    ans <- .Call("nnRecv", socket, dont.wait, PACKAGE="rnanomsg")

    if(!is.null(ans) && unserialize) {
        ans <- unserialize(ans)
    }
    ans
}

# distinguished constants used by nanomsg
nn.NS_NAMESPACE <- nn("NN_NS_NAMESPACE")
nn.NS_VERSION <- nn("NN_NS_VERSION")
nn.NS_DOMAIN <- nn("NN_NS_DOMAIN")
nn.NS_TRANSPORT <- nn("NN_NS_TRANSPORT")
nn.NS_PROTOCOL <- nn("NN_NS_PROTOCOL")
nn.NS_OPTION_LEVEL <- nn("NN_NS_OPTION_LEVEL")
nn.NS_SOCKET_OPTION <- nn("NN_NS_SOCKET_OPTION")
nn.NS_TRANSPORT_OPTION <- nn("NN_NS_TRANSPORT_OPTION")
nn.NS_OPTION_TYPE <- nn("NN_NS_OPTION_TYPE")
nn.NS_FLAG <- nn("NN_NS_FLAG")
nn.NS_ERROR <- nn("NN_NS_ERROR")
nn.NS_LIMIT <- nn("NN_NS_LIMIT")
nn.TYPE_NONE <- nn("NN_TYPE_NONE")
nn.TYPE_INT <- nn("NN_TYPE_INT")
nn.TYPE_STR <- nn("NN_TYPE_STR")
nn.UNIT_NONE <- nn("NN_UNIT_NONE")
nn.UNIT_BYTES <- nn("NN_UNIT_BYTES")
nn.UNIT_MILLISECONDS <- nn("NN_UNIT_MILLISECONDS")
nn.UNIT_PRIORITY <- nn("NN_UNIT_PRIORITY")
nn.UNIT_BOOLEAN <- nn("NN_UNIT_BOOLEAN")
nn.VERSION_CURRENT <- nn("NN_VERSION_CURRENT")
nn.VERSION_REVISION <- nn("NN_VERSION_REVISION")
nn.VERSION_AGE <- nn("NN_VERSION_AGE")
nn.AF_SP <- nn("AF_SP")
nn.AF_SP_RAW <- nn("AF_SP_RAW")
nn.INPROC <- nn("NN_INPROC")
nn.IPC <- nn("NN_IPC")
nn.TCP <- nn("NN_TCP")
nn.PAIR <- nn("NN_PAIR")
nn.PUB <- nn("NN_PUB")
nn.SUB <- nn("NN_SUB")
nn.REP <- nn("NN_REP")
nn.REQ <- nn("NN_REQ")
nn.PUSH <- nn("NN_PUSH")
nn.PULL <- nn("NN_PULL")
nn.SURVEYOR <- nn("NN_SURVEYOR")
nn.RESPONDENT <- nn("NN_RESPONDENT")
nn.BUS <- nn("NN_BUS")
nn.SOCKADDR_MAX <- nn("NN_SOCKADDR_MAX")
nn.SOL_SOCKET <- nn("NN_SOL_SOCKET")
nn.LINGER <- nn("NN_LINGER")
nn.SNDBUF <- nn("NN_SNDBUF")
nn.RCVBUF <- nn("NN_RCVBUF")
nn.SNDTIMEO <- nn("NN_SNDTIMEO")
nn.RCVTIMEO <- nn("NN_RCVTIMEO")
nn.RECONNECT_IVL <- nn("NN_RECONNECT_IVL")
nn.RECONNECT_IVL_MAX <- nn("NN_RECONNECT_IVL_MAX")
nn.SNDPRIO <- nn("NN_SNDPRIO")
nn.SNDFD <- nn("NN_SNDFD")
nn.RCVFD <- nn("NN_RCVFD")
nn.DOMAIN <- nn("NN_DOMAIN")
nn.PROTOCOL <- nn("NN_PROTOCOL")
nn.IPV4ONLY <- nn("NN_IPV4ONLY")
nn.SOCKET_NAME <- nn("NN_SOCKET_NAME")
nn.SUB_SUBSCRIBE <- nn("NN_SUB_SUBSCRIBE")
nn.SUB_UNSUBSCRIBE <- nn("NN_SUB_UNSUBSCRIBE")
nn.REQ_RESEND_IVL <- nn("NN_REQ_RESEND_IVL")
nn.SURVEYOR_DEADLINE <- nn("NN_SURVEYOR_DEADLINE")
nn.TCP_NODELAY <- nn("NN_TCP_NODELAY")
nn.DONTWAIT <- nn("NN_DONTWAIT")
nn.EADDRINUSE <- nn("EADDRINUSE")
nn.EADDRNOTAVAIL <- nn("EADDRNOTAVAIL")
nn.EAFNOSUPPORT <- nn("EAFNOSUPPORT")
nn.EAGAIN <- nn("EAGAIN")
nn.EBADF <- nn("EBADF")
nn.ECONNREFUSED <- nn("ECONNREFUSED")
nn.EFAULT <- nn("EFAULT")
nn.EFSM <- nn("EFSM")
nn.EINPROGRESS <- nn("EINPROGRESS")
nn.EINTR <- nn("EINTR")
nn.EINVAL <- nn("EINVAL")
nn.EMFILE <- nn("EMFILE")
nn.ENAMETOOLONG <- nn("ENAMETOOLONG")
nn.ENETDOWN <- nn("ENETDOWN")
nn.ENOBUFS <- nn("ENOBUFS")
nn.ENODEV <- nn("ENODEV")
nn.ENOMEM <- nn("ENOMEM")
nn.ENOPROTOOPT <- nn("ENOPROTOOPT")
nn.ENOTSOCK <- nn("ENOTSOCK")
nn.ENOTSUP <- nn("ENOTSUP")
nn.EPROTO <- nn("EPROTO")
nn.EPROTONOSUPPORT <- nn("EPROTONOSUPPORT")
nn.ETERM <- nn("ETERM")
nn.ETIMEDOUT <- nn("ETIMEDOUT")
nn.EACCES <- nn("EACCES" )
nn.ECONNABORTED <- nn("ECONNABORTED")
nn.ECONNRESET <- nn("ECONNRESET")
nn.EHOSTUNREACH <- nn("EHOSTUNREACH")
nn.EMSGSIZE <- nn("EMSGSIZE")
nn.ENETRESET <- nn("ENETRESET")
nn.ENETUNREACH <- nn("ENETUNREACH")
nn.ENOTCONN <- nn("ENOTCONN")
