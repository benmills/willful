DescribeContext := Object clone do(
  contexts := List clone

  init := method(
    self tests := Map clone
  )

  it := method(description, 
    self tests atPut(description, block setMessage(call argAt(1)))
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
      e catch(Exception,
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
