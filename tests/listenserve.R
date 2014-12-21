#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@

library(nanomsgardvark)

# nanomsg endpoint to use in tests cases.
#test.ENDPOINT <- "inproc://poll"
#test.ENDPOINT <- "ipc:///tmp/test.ipc"
test.ENDPOINT <- "tcp://0.0.0.0:5551"

# Testing helpers.
assert <- function(condition, message="Assertion Failed") if(!condition) stop(message)
assert.fails <- function(expr, message="Assertion Failed") {
    result <- try(expr, TRUE)
    assert(inherits(result, 'try-error'), message)
}


    s.pull <- nn.socket(nn.AF_SP, nn.PULL)

    nn.clearerr()
    rc = nn.bind(s.pull, test.ENDPOINT)
    assert(rc > 0, "nn.bind() should return positive endpoint id")

    grover=0
    found=0
    handler = function(msg) {
       #cat(file=stderr(),"hanlder() called, on err\n")
       #print(paste(sep="","handler() sees msg = '", unserialize(msg),"'"))
       grover<<-grover+1
       umsg = unserialize(msg)
       g = grep("Hello.*World",umsg)
       if (length(g) > 0) {
          found <<- found+1
          if (found %% 1000 == 0) {
             #print(paste(sep="", "found is at: ",found))
          }
       }
    }

    print(paste("listening on ", test.ENDPOINT,"and calling back to handler"))
    servrc <- nn.listen.and.serve(s.pull, handler)
    # doesn't return does do call back on handler
