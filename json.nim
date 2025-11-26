import std/json
import std/options

# reading
let jsonNode = parseJson("""{"key": 3.14}""")
assert jsonNode.kind == JObject
assert jsonNode["key"].kind == JFloat

let a11 = parseJson("""{"key": 3.14}""")
echo pretty(a11)
assert jsonNode["key"].getFloat() == 3.14

# unmarshalling
type
  User = object
    name: string
    age: int

let userJson = parseJson("""{"name": "Nim", "age": 12}""")
let user = json.to(userJson, User)
echo user

# creating
var hisName = "John"
let herAge = 31
var j = %*
  [
    {"name": hisName, "age": 30},
    {"name": "Susan", "age": herAge}
  ]

var j2 = %* {"name": "Isaac", "books": ["Robot Dreams"]}
j2["details"] = %* {"age": 35, "pi": 3.1415}
echo j2
