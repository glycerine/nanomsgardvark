library(nanomsgardvark)

# nanomsg endpoint to use in tests cases.
test.ENDPOINT <- "inproc://poll"

#test.ENDPOINT <- "ipc:///tmp/test.ipc"
#test.ENDPOINT <- "tcp://127.0.0.1:5556"

# Testing helpers.
assert <- function(condition, message="Assertion Failed") if(!condition) stop(message)
assert.fails <- function(expr, message="Assertion Failed") {
    result <- try(expr, TRUE)
    assert(inherits(result, 'try-error'), message)
}


# A basic test of poll functionality with nn.recv()
test.nanomsgardvark.poll.basic <- function() {
    s.rep <- nn.socket(nn.AF_SP, nn.REP)
    s.req <- nn.socket(nn.AF_SP, nn.REQ)

    rc = nn.bind(s.rep, test.ENDPOINT)
    assert(rc > 0, "nn.bind() should return positive endpoint id")

    rc = nn.connect(s.req, test.ENDPOINT)
    assert(rc > 0, "nn.connect() should return positive endpoint id")

    pollrc <- nn.recv(s.rep, unserialize=TRUE, dont.wait = TRUE)
    assert(pollrc == -1, "nn.recv() should return -1")
    assert(nn.strerror() == "Resource temporarily unavailable", "nn.strerror() should return 'Resource temporarily unavailable'")

    nn.clearerr()
    sendrc = nn.send(s.req, "Hello")
    assert(sendrc > 0, "nn.send('Hello') should return positive integer indicating success.")
    
    nn.clearerr()
    pollrc <- nn.recv(s.rep, unserialize=TRUE, dont.wait = TRUE)
    assert(pollrc == "Hello", "nn.recv() should return 'Hello'")

    # try again, this time nothing should be there
    nn.clearerr()
    pollrc <- nn.recv(s.rep, unserialize=TRUE, dont.wait = TRUE)
    assert(pollrc == -1, "nn.recv() should return -1")
    assert(nn.strerror() == "Resource temporarily unavailable", "nn.strerror() should return 'Resource temporarily unavailable'")

    rc = nn.close(s.rep)
    assert(rc == 0, "nn.close() should return 0")
    rc = nn.close(s.req)
    assert(rc == 0, "nn.close() should return 0")
}


# Run tests.
test.nanomsgardvark.poll.basic()
