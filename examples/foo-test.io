doFile("lib/willful.io")

# Code
Foo := Object clone do(bar := method("bar"))
Boo := Object clone do(baz := method("baz"))

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
  
  it("fails when the exception is that a method is called which DNE",
    "abc" someNonexistentMethod
  )
) 

describe("Boo",
  it("Will baz", 
    f := Boo clone
    f baz will == "bzzaz"
  )
) 
