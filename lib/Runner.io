Runner := Object clone do(
  groups := List clone
  specs := List clone

  withGroups := method(groups,
    groups foreach(group,
      group specs foreach(spec,
        specs append(spec)
      )
    )

    self 
  )

  withTags := method(tags,
    if(tags isNil, tags := Map clone)

    taggedSpecs := List clone
    specs foreach(spec,
      if(spec evalTags(tags), taggedSpecs append(spec))
    )
    
    taggedRunner := self clone
    taggedRunner specs = taggedSpecs 
    taggedRunner
  )

  run := method(
    failed := List clone

    specs foreach(spec,
      response := spec run
      success := response == nil
      specOutput(success, spec)

      if(success == false,
        responseObj := Object clone
        responseObj msg := response
        responseObj spec := spec description
        responseObj context := spec context
        failed append(responseObj)
      )
    )
    
    totalOutput(failed)
  )

  specOutput := method(success,
    if(success, "." print, "F" print)
  )

  totalOutput := method(failed,
    ("\n" .. specs size .. " specs, " .. failed size .. " failures") println
    currentContext := nil
    failed foreach(fail,
      if(fail context != currentContext,
        "" println
        currentContext = fail context
        fail context description println 
      )
      ("    " .. fail spec .. " failed: " .. fail msg) println
    )
  )
)
