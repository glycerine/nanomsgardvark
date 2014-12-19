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
SOCKET_ADDRESS <- "tcp://127.0.0.1:5556"

# publisher
pub1 = nn.socket(nn.AF_SP, nn.PUB);
nn.bind(pub1, SOCKET_ADDRESS);

# subscriber #1
sub1 = nn.socket (nn.AF_SP, nn.SUB);
rc = nn.setsockopt (sub1, nn.SUB, nn.SUB_SUBSCRIBE, "");
assert (rc == 0, "expected rc = 0 after setsockopt");
nc = nn.connect(sub1, SOCKET_ADDRESS);

# expect to get -1 back on this query
rc = nn.getsockopt (sub1, nn.SUB, nn.SUB_SUBSCRIBE);
assert (rc == -1 && nn.errno () == nn.ENOPROTOOPT);


# subscriber #2
sub2 = nn.socket(nn.AF_SP, nn.SUB);
rc = nn.setsockopt (sub2, nn.SUB, nn.SUB_SUBSCRIBE, "");
assert(rc == 0,"expected 0 from setsockopt");
nc2 = nn.connect (sub2, SOCKET_ADDRESS);

#  Wait till connections are established to prevent message loss.
Sys.sleep(.010)

rc3 = nn.send(pub1, "0123456789012345678901234567890123456789");
assert(rc3 == 70,paste("expected 70 from nn.send, got: ", rc3));

r1=nn.recv(sub1)
assert(r1 == "0123456789012345678901234567890123456789", "receive didn't match")
r2=nn.recv(sub2)
assert(r2 == "0123456789012345678901234567890123456789", "receive didn't match")

nn.close (pub1);
nn.close (sub1);
nn.close (sub2);

