AssertionFailed := Exception clone

Spec := Object clone do(
  withDescription := method(description, 
    self description := description; self
  )

  withTest := method(test,
    self test := block setMessage(test) setScope(self); self
  )

  withTags := method(tags,
    self tags := tags; self
  )
  
  evalTags := method(tagsToMatch,
    tagScope := Object clone do(
      tags := method(
        result := true

        Object forward := method(
          methodName := call message name
          args := call message argsEvaluatedIn(call sender)
        )

        tagsToMatch foreach(k,v,
          Object setSlot(k, v)
        ) 
        
        call evalArgs foreach(t, if(t == false, result = false))
        result
      )
    )

    tagScope tagsToMatch := tagsToMatch
    if(tags,
      block setMessage(tags) setScope(tagScope) call
    )
  )

  run := method(
    try(self test call) ?error
  )

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
)
