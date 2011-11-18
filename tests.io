Importer addSearchPath("lib")

assert := method(msg, cond,
  if(cond, "." print; return)
  Exception raise("Failed: " .. msg)
)

doTest := method(file,
  doFile("tests/" .. file .. "-test.io")
  "" println
)

doTest("spec")
doTest("spec-group")
doTest("runner")
