Importer addSearchPath("lib")
AssertionFailed := Exception clone

describe := method(description,
  context := DescribeContext clone
  context description := description 
  DescribeContext contexts append(context)

  itGroup := block setMessage(call argAt(1))
  itGroup setScope(context) 
  itGroup call
  
  context
)
