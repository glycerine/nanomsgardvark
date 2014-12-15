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

pub = nn.socket (nn.AF_SP, nn.PUB);

rc = nn.bind(pub, test.ENDPOINT)
assert(rc > 0, "nn.bind() should return positive endpoint id")

# we run a loop with a sleep in it to avoid the race
# that happens when a publisher starts, spits out some messages,
# and then stopped before the subscriber ever has a chance to
# get connected.

for (i in 1:500) {
 nbytes = nn.send (pub, charToRaw(paste("foo|Hello!",i)), serialize=F);
 print(paste("sent foo|Hello!", i))

 nbytes = nn.send (pub, charToRaw("baz|World!"), serialize=F);
 print(paste("sent baz|World!"))

 Sys.sleep(1)
}

