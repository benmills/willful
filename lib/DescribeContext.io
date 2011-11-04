AssertionFailed := Exception clone

DescribeContext := Object clone do(
  contexts := Map clone

  getConext := method(description,
    context := DescribeContext clone
    if(DescribeContext contexts hasKey(description),
      DescribeContext contexts at(description)
    ,
      context := DescribeContext clone setDescription(description)
      DescribeContext contexts atPut(description, context)
      context
    )
  )

  addContext := method(description, tests, tags,
    DescribeContext getConext(description) evalTests(tests) addTags(tags)
  )

  init := method(
    self tests := Map clone
  )

  addTags := method(tags,
    self tags := tags
    self
  )

  evalTests := method(tests,
    block setMessage(tests) setScope(self) call
    self 
  )

  setDescription := method(description, 
    self description := description
    self
  )

  it := method(description, 
    hasTags := call argCount == 3
    tagMap := if(hasTags, doMessage(call argAt(1)), Map clone)
    test := if(hasTags, call argAt(2), call argAt(1))

    testObj := Object clone
    testObj test := block setMessage(test)
    testObj tags := tagMap

    self tests atPut(description, testObj)
  )

  hasTestsForFilter := method(filterKey, filterVal,
    hasTests := false
    if(filterKey and filterVal,
      tests foreach(description, testObj,
        if(testObj tags at(filterKey) == filterVal, hasTests = true)
      )
    )
    hasTests
  )

  run := method(callback, filterKey, filterVal, overrideFilter,
    passedTests     := 0
    failedTests     := 0
    testCount       := 0
    assertionErrors := List clone
    filter          := filterKey != nil and filterVal != nil
    if(overrideFilter, filter = false)

    tests foreach(description, testObj,
      if(filter == false or (testObj tags at(filterKey) == filterVal),
        testCount = testCount + 1
        passed := true
        resposne := testObj test setScope(WillContext clone) run

        if(resposne,
          assertionErrors append(description .. ": " .. resposne)
          callback? call(false)
        ,
          callback? call(true)
        )
      )
    )

    Map clone with(
      "total", testCount,
      "passed", testCount - assertionErrors size,
      "failed", assertionErrors size,
      "errors", assertionErrors
    )
  )
)
