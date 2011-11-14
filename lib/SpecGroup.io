SpecGroup := Object clone do(
  groups := Map clone

  add := method(description, tests,
    if(groups hasKey(description), break(groups at(description) evalTests(tests)))

    group := self clone withDescription(description) evalTests(tests)
    groups atPut(description, group)
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
    spec := Spec clone withDescription(description) withTest(call argAt(call argCount - 1)) withTags(if(call argCount == 3, call argAt(1)))
    self specs atPut(description, spec)
  )
)
