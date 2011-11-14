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

      specOutput(response == nil)
      failed append(response)
    )
    
    totalOutput(failed)
  )

  specOutput := method(success,
    if(success, "." print, "F" print)
  )

  totalOutput := method(failed,
    ("\n" .. specs size .. " specs, " .. failed size .. " failures") println
  )
)
