"Testing Runner" println
fakeTest := doFile("tests/fake-test.io")
Runner specOutput := method()
Runner totalOutput := method(failed,
  Map clone with(
    "failed", failed size,
    "total", specs size,
    "failedMsgs", failed
  )
)

runner := Runner clone withGroups(List clone with(fakeTest))

output := runner run
assert("It should have 3 total specs", output at("total") == 3)
assert("It should have 1 failed specs", output at("failed") == 1)
assert("It should have 1 failed message", output at("failedMsgs") size == 1 and
                                          output at("failedMsgs") first msg == "Expected true got false")
output := runner withTags run
assert("It should have 1 total specs", output at("total") == 1)

output := runner withTags(Map clone with(
  "foo", "zed"
)) run
assert("It should have 2 total specs", output at("total") == 2)

output := runner withTags(Map clone with(
  "version", 1
)) run
assert("It should have 2 total specs", output at("total") == 2)
