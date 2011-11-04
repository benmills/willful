Importer addSearchPath("lib")

: := method(val,
  list(self, val)
)

tags := method(
  tagMap := Map clone
  call message arguments foreach(arg,
    result := doMessage(arg)
    tagMap atPut(result at(0), result at(1))
  )
  tagMap
)

describe := method(description,
  hasTags := call argCount == 3
  tagMap := if(hasTags, doMessage(call argAt(1)), Map clone)
  tests := if(hasTags, call argAt(2), call argAt(1))
  DescribeContext addContext(description, tests, tagMap)
)
