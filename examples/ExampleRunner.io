group := doFile("examples/foo-test.io")

runner := Runner withGroups(List clone append(group)) 

//runner run
//writeln("_________________________________")_

runner specOutput := method(success, spec,
  spec description println 
)

runner withTags(Map clone with(
  "version", 1.24
)) run 
