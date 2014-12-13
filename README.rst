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

The rzmq bindings by Whit Armstrong served as a template when writing these Nanomsg bindings.
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
	context = init.context()
	socket = init.socket(context,"ZMQ_REP")
	bind.socket(socket,"tcp://*:5555")
	while(1) {
	    msg = receive.socket(socket);
	    fun <- msg$fun
	    args <- msg$args
	    print(args)
	    ans <- do.call(fun,args)
	    send.socket(socket,ans);
	}
	
and execute this bit locally::

	library(rnanomsg)
	
	remote.exec <- function(socket,fun,...) {
	    send.socket(socket,data=list(fun=fun,args=list(...)))
	    receive.socket(socket)
	}
	
	substitute(expr)
	context = init.context()
	socket = init.socket(context,"ZMQ_REQ")
	connect.socket(socket,"tcp://localhost:5555")
	
	ans <- remote.exec(socket,sqrt,10000)
	
