"Testing Spec" println

spec := Spec clone withDescription("Test description")
assert("It has a description", spec description == "Test description")

spec := Spec clone withContext("my context")
assert("It has a context", spec context == "my context")

tags := Map clone with("foo", "bar")
spec := Spec clone withTags(tags)
assert("It has tags", spec tags == tags)

makeSpec := method(
  Spec clone withTest(call argAt(0))
)

spec := makeSpec(
  f := Object clone do( foo := method("foo"))
  f foo will == "foo"
)
assert("It returns nil when the test passes", spec run == nil)

spec := makeSpec(
  f := Object clone do( foo := method("foo"))
  f bar will == "foo"
)
assert("It returns the error when the test fails", spec run == "Object does not respond to 'bar'")

makeSpec := method(
  Spec clone withTags(call argAt(0))
)
spec := makeSpec(
  tags(foo == "bar")
)
assert("It will return true if eval tags are true", spec evalTags(Map clone with("foo", "bar")))
spec := makeSpec(

  tags(foo == "bar")
)
assert("It will return false if any eval tags are false", spec evalTags(Map clone with("foo", "baz")) == false)
