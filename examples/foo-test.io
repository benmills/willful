doFile("lib/willful.io")

# Code
Foo := Object clone do(bar := method("bar"))
Boo := Object clone do(baz := method("baz"))

# Tests
describe("Foo", tags(version: "1.23"),

  it("Will bar", tags(version: "1.23"),
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

describe("Boo", tags(version: "1.23"),
  it("Will baz", tags(version: "1.23"),
    f := Boo clone
    f baz will == "bzzaz"
  )
  it("nothing",
    Object will beOk
  )
)

describe("Foo",
  it("bar again",
    f := Foo clone
    f bar will == "bar"
  )
)
