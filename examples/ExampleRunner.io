group := doFile("examples/foo-test.io")

Runner withGroups(List clone append(group)) withTags(Map clone with(
  "version", 1.23
)) run
