#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@

library(nanomsgardvark)

assert <- function(condition, message="Assertion Failed") if(!condition) stop(message)
assert.fails <- function(expr, message="Assertion Failed") {
    result <- try(expr, TRUE)
    assert(inherits(result, 'try-error'), message)
}


# nanomsg endpoint to use in tests cases.
test.ENDPOINT <- "tcp://127.0.0.1:5556"

sub = nn.socket (nn.AF_SP, nn.SUB);

rc = nn.setsockopt (sub, nn.SUB, nn.SUB_SUBSCRIBE, "f");
#rc = nn.setsockopt (sub, nn.SUB, nn.SUB_SUBSCRIBE, charToRaw("bar"), unserialize=FALSE);

rc = nn.connect(sub, test.ENDPOINT)
assert(rc > 0, "nn.connect() should return positive endpoint id")

for (i in 1:20) {
nbytes = nn.recv (sub, unserialize=FALSE);
print(paste("I got ", rawToChar(nbytes)))
}
