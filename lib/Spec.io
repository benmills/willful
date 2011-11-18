AssertionFailed := Exception clone

Spec := Object clone do(

  withContext := method(context,
    self context := context; self
  )

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
        tagsToMatch foreach(k,v, Object setSlot(k, v)) 

        e := try(call evalArgs foreach(t, if(t == false, result = false)))
        if(e, result = false)

        tagsToMatch foreach(k,v, Object removeSlot(k, v)) 
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