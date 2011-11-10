Importer addSearchPath("lib")

tags := method(
  tagMap := Map clone
  call message arguments foreach(arg, arg doInContext(tagMap))
  tagMap
)

describe := method(description,
  hasTags := call argCount == 3
  tagMap := if(hasTags, doMessage(call argAt(1)), Map clone)
  tests := if(hasTags, call argAt(2), call argAt(1))

  DescribeContext addContext(description, tests, tagMap)
)
