## base64
import std/base64

let encoded = encode("hello world")
echo encoded
let encodedInts = encode([1'u8, 2, 3])
assert encodedInts == "AQID"
let encodedChars = encode(['h', 'e', 'y'])
assert encodedChars == "aGV5"
let decoded = decode("aGVsbG8gd29ybGQ=")
assert decoded == "hello world"

## hashes
import std/hashes

type Something = object
  foo: int
  bar: string

iterator items(x: Something): Hash =
  yield hash(x.foo)
  yield hash(x.bar)

proc hash(x: Something): Hash =
  var h: Hash = 0
  for xAtom in x:
    h = h !& xAtom

  return !$h

