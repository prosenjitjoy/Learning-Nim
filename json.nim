import std/json
import std/options

# reading
let jsonNode = parseJson("""{"key": 3.14}""")
assert jsonNode.kind == JObject
assert jsonNode["key"].kind == JFloat

let a11 = parseJson("""{"key": 3.14}""")
echo pretty(a11)
assert jsonNode["key"].getFloat() == 3.14

let jsonNode1 = parseJson("{}")
assert jsonNode1{"nope"}.getInt() == 0
assert jsonNode1{"nope"}.getFloat() == 0
assert jsonNode1{"nope"}.getStr() == ""
assert jsonNode1{"nope"}.getBool() == false

let jsonNode2 = parseJson("""{"key": 3.14, "key2": null}""")
assert jsonNode2["key"].getFloat(6.28) == 3.14
assert jsonNode2["key2"].getFloat(3.14) == 3.14
assert jsonNode2{"nope"}.getFloat(6.28) == 6.28

# unmarshalling
type
  User = object
    name: string
    age: int
    `type`: Option[string]

let userJson = parseJson("""{"name": "Nim", "age": 12, "type": "human"}""")
let user = json.to(userJson, User)
if user.`type`.isSome():
  assert user.`type`.get() != "robot!"
  echo user

# creating
var hisName = "John"
let herAge = 31
var j = %*
  [
    {"name": hisName, "age": 30},
    {"name": "Susan", "age": herAge}
  ]
echo j

var j2 = %* {"name": "Isaac", "books": ["Robot Dreams"]}
j2["details"] = %* {"age": 35, "pi": 3.1415}
echo pretty(j2)

let userJson1 = %user
echo pretty(userJson1)

let arr = %[0, 1, 2, 3, 4, 5]
echo pretty(arr)
