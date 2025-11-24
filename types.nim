import std/strformat
import std/setutils
import std/os

## enum
type
  Direction = enum
    north = 7
    east = 11
    south
    west

var x: Direction = south
echo ord(x)
var str: string = $x
echo str
# echo str.typeof
echo typeof(str)

if x == Direction.south:
  echo "It's south!"

## subranges
type
  MySubrange = range[0..5]
var mySubrange: MySubrange = 5

## sets
# var s: set[int64] # system.set can't be greater than int16
var s: set[int16]
echo typeof(s)

var charSet: set[char]
charSet = {'a'..'z', '0'..'9'}
echo len(charSet)

var astring: string = "pick piper pickle"
let uniqueChars = toSet(astring)
echo uniqueChars

echo 'q' in uniqueChars
echo contains(uniqueChars, 'q')
echo card(uniqueChars)

## arrays
type
  IntArray = array[0..5, int] # an array that is indexed with 0..5

var xarr: IntArray
xarr = [1, 2, 3, 4, 5, 6]
for i in low(xarr)..high(xarr):
  echo xarr[i]

var arr: array[0..9, int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
for idx, item in arr.pairs:
  echo fmt"{idx}: {item}"
for item in arr.items:
  echo item

type
  Directions = enum
    north, east, south, west
  BlinkLights = enum
    off, on, slowBlink, mediumBlink, fastBlink
  LevelSetting = array[Directions, BlinkLights]
  LightTower = array[1..10, LevelSetting]

var level: LevelSetting
level[north] = on
level[south] = slowBlink
level[east] = fastBlink
echo level
echo low(level)
echo len(level)
echo high(level)

var tower: LightTower
tower[1][north] = slowBlink
tower[1][east] = mediumBlink
echo len(tower)
echo len(tower[1])
echo tower

type
  QuickArray = array[6, int]

var y: QuickArray
y = xarr
echo y

## sequences
var
  xseq: seq[int]

xseq = @[9, 2, 3, 4, 5, 6, 7, 8]
echo len(xseq)
echo low(xseq)
echo high(xseq)
echo xseq[^1]
for i, v in xseq[0..^1]:
  echo fmt"{i}: {v}"
for v in xseq:
  echo v

## open arrays
## mainly used for accepting variable length array as parameter to procedure
var
  fruits: seq[string]
  capitals: array[3, string]

capitals = ["New York", "London", "Berlin"]
fruits.add("Banana")
fruits.add("Mango")

proc openArraySize(oa: openArray[string]): int =
  return len(oa)

assert openArraySize(fruits) == 2
assert openArraySize(capitals) == 3

## varargs
## mainly used for passing variable number of argument to procedure
proc myWriteln(f: File, a: varargs[string]) =
  for s in items(a):
    write(f, s)
  write(f, "\n")

myWriteln(stdout, "abc", "def", "xyz")
# is transformed by the compiler to
myWriteln(stdout, ["abc", "def", "xyz"])

proc myWritelnString(f: File, a: varargs[string, `$`]) =
  for s in items(a):
    write(f, s)
  write(f, "\n")
myWritelnString(stdout, 123, "abc", 4.0)
# is transformed by the compiler to
myWritelnString(stdout, [$123, $"abc", $4.0])

# slices
var
  a = "Nim is a programming language"
  b = "Slices are useless."
echo typeof(a), typeof(b)

echo len(b)
b[11..^2] = "useful"
echo len(b)

## objects
type Person = object
  name: string
  age: int

var person1: Person = Person(name: "Peter", age: 30)
echo person1.name
echo person1.age

var person2: Person = person1
person2.age += 14
echo person1.age
echo person2.age

let person3: Person = Person(age: 12, name: "Quentin")
echo person3

# unspecified member will be initialized with their default value
let person4: Person = Person(age: 3)
doAssert person4.name == ""

# * specified that the object should be visible from other modules
type House* = object
  room*: int
  door*: int

## tuples
type
  # object like syntax
  Human = tuple
    name: string
    age: int
  # alternative syntax
  Human1 = tuple[name: string, age: int]
  # anonymous field syntax
  Human2 = (string, int)

var
  human: Human
  human1: Human1
  human2: Human2

human = (name: "Peter", age: 30)
# Human and Human1 are equivalent
human1 = human
# Create a tuple with anonymous fields
human2 = ("Peter", 30)
human = human2

echo human[0]
echo human[1]

var building: tuple[street: string, number: int]
building = ("Rue del Percebe", 13)
echo building.street

let
  path = "/usr/local/nimc.html"
  (dir, name, ext) = splitFile(path)
  baddir, badname, badext = splitFile(path)

echo dir
echo name
echo ext

echo baddir
echo badname
echo badext

let ta = [(10, 'a'), (20, 'b'), (30, 'c')]
echo typeof(ta)

for (x, c) in ta:
  echo x

for i, (x, c) in ta:
  echo i, c

## reference and pointer types
type
  Node = ref object
    left: Node
    right: Node
    data: int

var n = Node(data: 9)
echo repr(n)
