doFile("lib/willful.io")

Foo := Object clone do( bar := method("baz") )

describe("Foo",
  it("will bar", tags(foo == "zed"),
    f := Foo clone
    f bar will == "baz"
  )

  it("will not zed", tags(true == true),
    f := Foo clone
    f bar will != "zed"
  )

  it("fails", tags(version > 0.5),
    false will == true
  )
)
