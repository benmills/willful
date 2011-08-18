doFile("lib/tests.io")

# Code
Foo := Object clone do(bar := method("bar"))

# Tests
describe("Foo") do(
  it("can return bar", block(
    f := Foo clone
    f bar will != "baz"
    f bar will == "bar"
    f bar will beOk
  ))

  it("can return zed", block(
    f := Foo clone
    f zed will == "zed"
  ))
) run
