## inheritance
type
  Person = ref object of RootObj
    name*: string
    age: int

  Student = ref object of Person
    id: int

var
  student: Student
  person: Person

echo student of Student

# object construction
student = Student(name: "Anton", age: 5, id: 2)

echo repr(student)
echo student[]

## interfaces
type
  IntFieldInterface = object
    getter: proc(): int
    setter: proc(x: int)

proc outer: IntFieldInterface =
  var captureMe = 0
  proc getter(): int =
    return captureMe
  proc setter(x: int) =
    captureMe = x

  return IntFieldInterface(
    getter: getter,
    setter: setter
  )

let obj = outer()
echo typeof(obj)
obj.setter(42)
echo obj.getter()

## mutually recursive types
type
  Node = ref object
    left: Node
    right: Node
    sym: ref Sym

  Sym = object
    name: string
    line: int
    code: Node

## object variants
type
  NodeKind = enum
    nkInt
    nkFloat
    nkString
    nkAdd
    nkSub
    nkIf

  Node1 = ref object
    case kind: NodeKind
    of nkInt:
      intVal: int
    of nkFloat:
      floatVal: float
    of nkString:
      stringVal: string
    of nkAdd, nkSub:
      leftOp: Node1
      rightOp: Node1
    of nkIf:
      condition: Node1
      thenPart: Node1
      elsePart: Node1

var n = Node1(kind: nkFloat, floatVal: 1.0)
echo repr(n)
# n.intVal = 2

## method call syntax
import std/strutils
import std/sequtils

echo len("abc"), "abc".len
echo toUpperAscii("abc"), "abc".toUpperAscii()
echo card({'a', 'b', 'c'}), {'a', 'b', 'c'}.card

writeLine(stdout, "Hallo")
stdout.writeLine("Hallo")

stdout.writeLine("Give a list of number (seperated by spaces): ")
stdout.write(stdin.readline.splitWhitespace.map(parseInt).max)
stdout.writeLine(" is the maximum!")

## properties
type
  Socket* = ref object of RootObj
    h: int

proc `host=`*(s: var Socket, value: int) {.inline.} =
  # setter of host address
  s.h = value

proc host*(s: Socket): int {.inline.} =
  # getter of host address
  return s.h

var s: Socket = Socket()
s.host = 42
echo s.host

type
  Vector* = object
    x: float
    y: float
    z: float

proc `[]=`*(v: var Vector, i: int, value: float) =
  # setter
  case i
  of 0:
    v.x = value
  of 1:
    v.y = value
  of 2:
    v.z = value
  else:
    assert(false)

proc `[]`*(v: Vector, i: int): float =
  # getter
  case i
  of 0:
    return v.x
  of 1:
    return v.y
  of 2:
    return v.z
  else:
    assert(false)

## dynamic dispatch / polymorphism
type
  Expression = ref object of RootObj
  Literal = ref object of Expression
    x: int
  PlusExpr = ref object of Expression
    a: Expression
    b: Expression

method eval(e: Expression): int {.base.} =
  quit "to override!"

method eval(e: Literal): int =
  return e.x

method eval(e: PlusExpr): int =
  return eval(e.a) + eval(e.b)

proc newLit(x: int): Literal =
  return Literal(x: x)

proc newPlus(a: Expression, b: Expression): PlusExpr =
  return PlusExpr(a: a, b: b)

echo eval(newPlus(newPlus(newLit(8), newLit(2)), newLit(4)))

type
  Thing = ref object of RootObj
  Unit = ref object of Thing
    x: int

method collide(a: Thing, b: Thing) {.inline.} =
  quit "to override"

method collide(a: Thing, b: Unit) {.inline.} =
  echo "1"

method collide(a: Unit, b: Unit) {.inline.} =
  echo "2"

method collide(a: Unit, b: Thing) {.inline.} =
  echo "3"

var b: Thing
var a: Unit
new a
new b
collide(a, b)
