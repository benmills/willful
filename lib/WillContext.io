WillContext := Object clone do(
  Object will := method(
    context := Object clone do(
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

      callback := method(message,
        if(message != true, AssertionFailed raise(message))
      )
    )

    context target := call target
    context
  )

  Object run := method(
    response := false
    e := try(self call)
    e catch(e, response = e error)

    response
  )

  Object forward := method(
    Exception raise("tried sending (" .. call message asString .. ") to " .. call target asString)
  )
)
