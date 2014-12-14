************
Introduction
************

:Date: Dec 13, 2014
:Authors: Jason E. Aten, Ph.D.
:Contact: j.e.aten@gmail.com
:Web site: http://github.com/glycerine/ardvark
:License: GPL-3 for ardvark. MIT for nanomsg.


Purpose
=======

ardvark is an R binding for nanomsg (http://nanomsg.org/).

ardvark was initially derived from the rzmq bindings for ZeroMQ by Whit Armstrong (https://github.com/armstrtw/rzmq). While ardvark has diverged significantly, some (most) of the docs are yet to be ported from zmq to nanomsg yet. In general the ardvark calls match the original nanomsg C calls exactly, so the nanomsg documentation (http://nanomsg.org/documentation.html) is extremely relevant and most useful.

Update: I originally named this project rnanomsg, before I realized that Matt Howlett had already started on R bindings (https://github.com/mhowlett/rnanomsg). I renamed the project ardvark after this discovery.

Features
========

ardvark is a network transport (over nanomsg) for serialized R (or other data) objects.



Usage
=====

A minimal example of sending code for remote execution.

execute this R script on the remote server::
    
    #!/usr/bin/env Rscript
    library(ardvark)
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
    
and execute this bit locally::

    library(ardvark)
    
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

