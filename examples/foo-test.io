doFile("lib/willful.io")

# Code
Foo := Object clone do(bar := method("bar"))

# Tests
describe("Foo",
  it("Will bar", 
    f := Foo clone
    f bar will == "bar"
    f bar will != "baz"
    f bar will beOk
  )

  it("fails when exceptions are raised",
    exception := Exception clone
    exception raise("an exception is raised!")
  )
) 
