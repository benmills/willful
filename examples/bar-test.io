doFile("lib/willful.io")

# Code
Bar := Object clone do(baz := method("baz"))

# Tests
describe("Bar",

  it("will baz",
    b := Bar clone
    b baz will == "baz"
  )

  it("will fail",
    b := Bar clone
    b boo will beOk
  )

)
