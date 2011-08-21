AssertionFailed := Exception clone

TestContext := Object clone do(
  setSlot("beOk", method(
    if(self target, callback(true), callback(false))
  ))
  setSlot("==", method(right,
    if(self target == right, callback(true), callback(
      "Expected " .. right .. " got " .. target
    ))
  ))
  setSlot("!=", method(right,
    if(self target != right, callback(true), callback(
      "Expected not " .. right .. " got " .. target
    ))
  ))
)

WillContext := Object clone do(
  Object will := method(
    context := TestContext clone
    context target := call target
    
    context callback := method(message,
      if(message != true, AssertionFailed raise(message))
    )
    return context
  )

  Object forward := method()
)

DescribeContext := Object clone do(
  contexts := List clone
  tests := Map clone

  it := method(description, test,
    self tests atPut(description, test)
  )

  run := method(callback,
    context := WillContext clone
    passedTests := 0
    failedTests := 0
    assertionErrors := List clone
    tests foreach(description, test,
      test setScope(context)
      e := try(test call)
      passed := true
      e catch(AssertionFailed, 
        passed = false
        assertionErrors append(description .. ": " .. e error)
      )
      if(passed, passedTests = passedTests+1, failedTests = failedTests+1)
      callback? call(passed)
    )
    results := Map clone
    results atPut("total", tests size)
    results atPut("passed", passedTests)
    results atPut("failed", failedTests)
    results atPut("errors", assertionErrors)
  )
)

describe := method(description,
  context := DescribeContext clone
  context description := description 
  DescribeContext contexts append(context)
  context
)
