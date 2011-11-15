Importer addSearchPath("lib")

assert := method(msg, cond,
  if(cond == false,
    Exception raise("Failed: " .. msg) 
  ,
    "." print
  )
)


doTest := method(file,
  doFile("tests/" .. file .. "-test.io")
  "" println
)

doTest("spec")
