************
Introduction
************

:Date: Dec 13, 2014
:Authors: Jason E. Aten
:Contact: j.e.aten@gmail.com
:Web site: http://github.com/glycerine/rnanomsg
:License: GPL-3


Purpose
=======

rnanomsg is an R binding for Nanomsg (http://nanomsg.org/).

The rzmq bindings by Whit Armstrong served as major inspiration when writing these Nanomsg bindings.
(https://github.com/armstrtw/rzmq). Some of the docs/etc might not be ported from zmq to nanomsg yet.

Features
========

rnanomsg is a message queue for serialized R objects.



Usage
=====

A minimal example of remote execution.

execute this R script on the remote server::
	
	#!/usr/bin/env Rscript
	library(rnanomsg)
    s.rep <- nn.socket(nn.AF_SP, nn.REP)
	nn.bind(s.req,"tcp://*:5555")
	while(1) {
	    msg = nn.recv(s.req);
        if nn.is.recv.err(msg) {
           stop(paste("problem with nn.recv", nn.strerror()))
        }
	    fun <- msg$fun
	    args <- msg$args
	    print(args)
	    ans <- do.call(fun,args)
	    rc = nn.send(s.req,ans);
        if nn.is.send.err(rc) {
           stop(paste("problem with nn.send", nn.strerror()))    
        }
	}
	
and execute this bit locally::

	library(rnanomsg)
	
	remote.exec <- function(socket,fun,...) {
	    send.socket(socket,data=list(fun=fun,args=list(...)))
	    receive.socket(socket)
	}
	
	substitute(expr)
    s.req <- nn.socket(nn.AF_SP, nn.REQ)

	connect.socket(s.req,"tcp://localhost:5555")
	
	ans <- remote.exec(s.req,sqrt,10000)
	
