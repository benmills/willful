doFile("lib/willful.io")

# Code
Foo := Object clone do(bar := method("bar"))

# Tests
describe("Foo",
  it("Will bar", 
    f := Foo clone
    f bar will == "bar"
  )
  it("Will not baz", 
    f := Foo clone
    f bar will == "baz"
  )
) 
