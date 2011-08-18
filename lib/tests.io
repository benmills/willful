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

  tests := Map clone

  it := method(description, test,
    self tests atPut(description, test)
  )

  run := method(
    "Running Tests..." println
    context := WillContext clone
    passedTests := 0
    failedTests := 0
    tests foreach(description, test,
      test setScope(context)
      e := try(test call)
      passed := true
      e catch(AssertionFailed, passed = false)
      if(passed, passedTests = passedTests+1; "." print, failedTests = failedTests+1;"F" print)
    )
    "\n---" println
    writeln(passedTests .. "/" .. (tests size) .. " tests passed")
  )
)

describe := method(description,
  DescribeContext clone
)
