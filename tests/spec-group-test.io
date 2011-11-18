"Testing Spec Group" println

group := SpecGroup clone withDescription("Test description")
assert("It has a description", group description == "Test description")


makeSpecGroup := method(
  SpecGroup clone evalTests(call argAt(0))
)
group := makeSpecGroup(
  it("has a test",
    true will == true
  )
)

assert("It evals tests", group specs size == 1 and
                         group specs values first description == "has a test")

makeSpecGroup := method(desc,
  SpecGroup add(desc, call argAt(1))
)
makeSpecGroup("Test description",
  it("has a test",
    true will == true
  )
)
assert("It adds groups", 
        SpecGroup groups size == 1 and
        SpecGroup groups values first description == "Test description" and
        SpecGroup groups values first specs size == 1)
