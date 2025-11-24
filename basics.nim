import strformat
from std/strutils import parseInt

var raw_string: string = r"C:\program files\nim"
echo raw_string

# useful of embedding HTML code
var long_string: string = """
<html>
  <head>
    <title>Hello World</title>
  </head>
  <body>
    <h1>Some title.</h1>
    <p>the quick brown fox jumps over the lazy dog. god yzal eht revo spmuj xof nworb kciuq eht.</p>
  </body>
</html>
"""
echo long_string

# A normal comment
## documentation comment

var myVariable: int ## a documentation comment

#[
multiline comments
can be useful to comment out nim code
  #[
  multiline comments can be nested!!
  ]#
]#

var largeNumber: int = 1_000_000
var realNumber: float = 1.0e9
echo realNumber

var x, y: int = 3
var
  a, b, c: string

a.add("hello")
b.add(" ")
c.add("world")
echo a, b, c

const str = "abc"
const
  p = 1
  q = 2
  r = p+5

## Error: only compile time expression can be used
# const input = readLine(stdin)
let input = readLine(stdin)
if input == "":
  echo "Poor soul, you lost your name?"
elif input == "name":
  echo "Verry funny, your name is name."
else:
  echo fmt"Hi, {input}!"


echo fmt"x: {x}, y: {y}"
x = 42
echo fmt"x: {x}, y: {y}"

let ask_name = readLine(stdin)
case ask_name
of "":
  echo "Poor soul, you lost your name?"
of "name":
  echo "Verry funny, your name is name."
of "Dave", "Frank":
  echo "Cool name!"
else:
  echo fmt"Hi, {ask_name}!"

echo "A number pelase: "
let n = parseInt(readLine(stdin))
case n
of 0..2, 4..7:
  echo "The number is in the set: {0,1,2,4,5,6,7}"
of 3, 8, 9:
  echo "The number is in the set {3,8,9}"
# else:
#   echo "The number is greater than 9"
else: discard

echo "What's your name?"
var name: string = readLine(stdin)
while name == "":
  echo "Please tell me your name: "
  name = readLine(stdin)

echo "Counting to ten: "
for i in 0..<10:
  echo i

# for i in countup(1, 10):
#   echo i

# var i: int = 1;
# while i <= 10:
#   echo i
#   # i += 1
#   inc i

echo "Counting down from 10 to 1: "
for i in countdown(10, 1):
  echo i

var s: string = "some string"
  # for i in 0..<s.len:
  #   echo s[i]

## for strings
for idx, c in s[0..^1]:
  echo fmt"{idx}: {c}"

## for arrays and sequences
for index, item in ["a", "b"].pairs:
  echo fmt"{item} at index {index}"

## explicit block
block myBlock:
  var x = "Hi!"
echo x

block myblock:
  echo "entering block"
  while true:
    echo "looping"
    break # leaves the loop, not the block
  echo "still in block"
echo "outside the block"

block myblock2:
  echo "entering block"
  while true:
    echo "looping"
    break myblock2 # leaves the block (and the loop)
  echo "still in block" # it won't be printed
echo "outside the block"

for i in 1..5:
  if i <= 3:
    continue
  echo i # will only print 4 and 5

## evaluated during compile time. like #ifdef construct of C
when system.hostOS == "windows":
  echo "running on Windows!"
elif system.hostOS == "linux":
  echo "running on Linux!"
elif system.hostOS == "macosx":
  echo "running on Mac OS X!"
else:
  echo "unknown operating system"

# computes fac(4) at compile time
const fac4 = (var fac = 1; for i in 1..4: fac *= i; fac)
echo fac4

proc ask(question: string): bool =
  echo fmt"{question} (y/n)"
  while true:
    case readLine(stdin)
    of "y", "Y", "yes", "Yes":
      return true
    of "n", "N", "no", "No":
      return false
    else:
      echo "Please be clear: yes or no"

if ask("Should I delete all your important files?"):
  echo "I'm sorry Dave, I'm afraid I can't do that."
else:
  echo "I think you know what the problem is just as well as I do."

# proc has a implicit variable called result if it returnes something
proc sumTillNegative(x: varargs[int]): int =
  for i in x:
    if i < 0:
      return
    result += i

echo sumTillNegative()
echo sumTillNegative(3, 4, 5)
echo sumTillNegative(3, 4, -1, 6)

proc helloWorld(): string =
  "Hello, World!"
echo helloWorld()

proc printSeq(s: seq, nprinted: int = -1) =
  var nprinted = if nprinted == -1: s.len else: min(nprinted, s.len)
  for i in 0..<nprinted:
    echo s[i]

printSeq(@[1, 2, 3, 4], 3)

proc divmod(a: int, b: int, res: var int, rem: var int) =
  res = a div b
  rem = a mod b
divmod(8, 5, x, y)
echo x, y

discard ask("May I ask a pointless question?")

proc add(x: int, y: int): int {.discardable.} =
  return x+y
add(3, 4)

proc toString(x: int): string =
  result = if x < 0: "negative" elif x > 0: "positive" else: "zero"

proc toString(x: bool): string =
  result = if x: "yep" else: "nope"

assert toString(13) == "positive"
assert toString(true) == "yep"

iterator countUp(a: int, b: int): int =
  var res = a
  while res <= b:
    yield res
    inc res

for i in countUp(1, 10):
  echo i

var ch: char = chr(97)
echo ch

var concatStr: string = "hello" & " " & "world"
concatStr.add("!")
echo concatStr

## int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64
let
  d = 0     # d is of type int
  e = 0'i8  # e is of type int8
  f = 0'i32 # f is of type int32
  g = 0'u   # u is of type uint

var tmp: int = 1 shl 4
echo tmp
tmp = tmp shr 1
echo tmp

## float float32 float64
let
  h = 0.0     # h is of type float
  i = 0.0'f32 # i is of type float32
  j = 0.0'f64 # j is of type float64

var
  k: int32 = 1.int32
  l: int8 = int8('a')
  m: float = 2.5
  sum: int = int(k) + int(l) + int(m)
assert sum == 100

type
  Person = tuple[name: string, age: int]

var person: Person = ("Prosenjit", 29)
echo fmt"{person}:{repr(person)}"

type
  House = ref object
    windows: int
    doors: int


var test: House = House()
echo repr(test)

type
  biggestInt = int64
  biggestFloat = float64
