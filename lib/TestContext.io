TestContext := Object clone do(
  setSlot("beOk", method(
    if(self target, callback(true), callback(false))
  ))
  setSlot("==", method(right,
    if(self target == right, callback(true), callback(
      "Expected " .. right .. " got " .. target
    ))
  ))
  setSlot("!=", method(right,
    if(self target != right, callback(true), callback(
      "Expected not " .. right .. " got " .. target
    ))
  ))
)
