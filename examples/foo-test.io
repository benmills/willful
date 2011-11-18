doFile("lib/willful.io")

# Code
Foo := Object clone do(bar := method("bar"))

# Tests
describe("Foo",

  it("bar will bar",
    f := Foo clone
    f bar will == "bar"
  )

  it("bar will not baz", tags(1 > 0),
    f := Foo clone
    f bar will == "baz"
  )

  it("will baz", tags(version == "ben"),
    f := Foo clone
    f baz will beOk
  )

)

describe("Foo",
  it("will have bar again",
    f := Foo clone
    f bar will == "bar"
  )
)
