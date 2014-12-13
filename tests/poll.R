library(rnanomsg)

# ZMQ inproc endpoint to use in tests cases.
test.ENDPOINT <- "inproc://poll"

# Testing helpers.
assert <- function(condition, message="Assertion Failed") if(!condition) stop(message)
assert.fails <- function(expr, message="Assertion Failed") {
    result <- try(expr, TRUE)
    assert(inherits(result, 'try-error'), message)
}


# A basic test of poll functionality with nn.recv()
test.rnanomsg.poll.basic <- function() {
    s.rep <- nn.socket(nn.AF_SP, nn.REP)
    s.req <- nn.socket(nn.AF_SP, nn.REQ)

    nn.bind(s.rep, test.ENDPOINT)
    nn.connect(s.req, test.ENDPOINT)

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

    nn.close(s.rep)
    nn.close(s.req)
}


# Run tests.
test.rnanomsg.poll.basic()
