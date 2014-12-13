###########################################################################
## Copyright (C) 2014  Jason E. Aten                                     ##
## rnanomsg is derived from rzmq, which is                               ##
## Copyright (C) 2011  Whit Armstrong                                    ##
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
    .Call("nnVersion", PACKAGE="rnanomsg")
}

nn.errno <- function() {
    .Call("nnErrno", PACKAGE="rnanomsg")
}

nn.strerror <- function() {
    .Call("nnStrerror", PACKAGE="rnanomsg")
}


nn.socket <- function(domain, socket.type) {
  .Call("nnSocket", domain, socket.type, PACKAGE="rzmq")
}  

nn.close <- function(socket) {
  .Call("nnClose", socket, PACKAGE="rzmq")
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

nn.recv <- function(socket, unserialize=TRUE,dont.wait=FALSE) {
    ans <- .Call("nnRecv", socket, dont.wait, PACKAGE="rnanomsg")

    if(!is.null(ans) && unserialize) {
        ans <- unserialize(ans)
    }
    ans
}
