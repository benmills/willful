SpecGroup := Object clone do(
  groups := Map clone

  add := method(description, tests,
    if(groups hasKey(description), break(groups at(description) evalTests(tests)))

    group := self clone withDescription(description) evalTests(tests)
    groups atPut(description, group)
    group
  )

  init := method(
    self specs := Map clone
  )

  evalTests := method(tests,
    block setMessage(tests) setScope(self) call; self
  )

  withDescription := method(description, 
    self description := description; self
  )

  it := method(description, 
    test := call argAt(call argCount - 1) 
    tags := if(call argCount == 3, call argAt(1))

    spec := Spec clone withDescription(description) withTest(test) withTags(tags) withContext(self)
    self specs atPut(description, spec)
  )
)
