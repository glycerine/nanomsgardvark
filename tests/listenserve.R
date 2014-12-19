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


    s.pull <- nn.socket(nn.AF_SP, nn.PULL)

    nn.clearerr()
    rc = nn.bind(s.pull, test.ENDPOINT)
    assert(rc > 0, "nn.bind() should return positive endpoint id")

    handler = function(msg) {
       print(paste("handler() sees msg = ", msg))
    }

    servrc <- nn.listen.and.serve(s.pull, handler, new.env())
    # doesn't return does do call back on handler
