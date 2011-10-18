doFile(System ioPath .. "/willful.io")

# Code
Foo := Object clone do(bar := method("bar"))

# Tests
describe("Foo") do(
  it("Will bar", block(
    f := Foo clone
    f bar will == "bar"
    f bar will != "baz"
    f bar will beOk
  ))

  it("fails when exceptions are raised", block(
    exception := Exception clone
    exception raise("an exception is raised!")
  ))
) 
