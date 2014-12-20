#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@

library(nanomsgardvark)

# nanomsg endpoint to use in tests cases.
#test.ENDPOINT <- "inproc://poll"
#test.ENDPOINT <- "ipc:///tmp/test.ipc"
test.ENDPOINT <- "tcp://127.0.0.1:5551"

# Testing helpers.
assert <- function(condition, message="Assertion Failed") if(!condition) stop(message)
assert.fails <- function(expr, message="Assertion Failed") {
    result <- try(expr, TRUE)
    assert(inherits(result, 'try-error'), message)
}


    s.push <- nn.socket(nn.AF_SP, nn.PUSH)

    nn.clearerr()
    rc = nn.connect(s.push, test.ENDPOINT)
    assert(rc > 0, "nn.connect() should return positive endpoint id")

    msg="Hello from sendmsg.R"

    nn.send(s.push,msg,serialize=T)

