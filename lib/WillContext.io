doRelativeFile("TestContext.io")

WillContext := Object clone do(
  Object will := method(
    context := TestContext clone
    context target := call target
    
    context callback := method(message,
      if(message != true, AssertionFailed raise(message))
    )

    context
  )

  # was originally overridden to return nil. I don't know why.
  # I'm changing it to raise an error so it doesn't hide missing method invocations (should fail-fast)
  Object forward := method(
    message := call sender asString .. "   tried sending (" .. call message asString .. ") to " .. call target asString
    Exception raise(message)
  )
)
