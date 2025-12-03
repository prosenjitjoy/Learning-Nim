## deques
import std/deques

var a = [10, 20, 30, 40].toDeque
a.addLast(50)
assert $a == "[10, 20, 30, 40, 50]"
assert a.peekFirst == 10
assert a.peekLast == 50
assert len(a) == 5
assert a.popFirst == 10
assert a.popLast == 50
assert len(a) == 3
a.addFirst(11)
a.addFirst(22)
a.addFirst(33)
assert $a == "[33, 22, 11, 20, 30, 40]"
a.shrink(fromFirst = 1, fromLast = 2)
assert $a == "[22, 11, 20]"

var a1, b1 = initDeque[int]()
a1.addFirst(2)
a1.addFirst(1)
b1.addLast(1)
b1.addLast(2)
assert a1 == b1
clear(a)
assert len(a) == 0
assert a1.contains(2)
assert 8 notin b1

from std/sequtils import toSeq
let b = [10, 20, 30, 40, 50].toDeque
assert toSeq(b.items) == @[10, 20, 30, 40, 50]
assert toSeq(b.pairs) == @[(0, 10), (1, 20), (2, 30), (3, 40), (4, 50)]

## heapqueue
import std/heapqueue

var heap = [8, 2].toHeapQueue
heap.push(5)
assert heap[0] == 2
assert heap.pop() == 2
assert heap[0] == 5

type Job = object
  priority: int

proc `<`(a: Job, b: Job): bool =
  return a.priority < b.priority

var jobs = initHeapQueue[Job]()
jobs.push(Job(priority: 1))
jobs.push(Job(priority: 2))
assert jobs[0].priority == 1
jobs.clear()
assert jobs.len == 0

assert heap.contains(8) == true
heap.push(9)
heap.del(1)
echo heap
assert heap.find(5) == 0
assert heap.find(9) == 1
assert heap.find(777) == -1

var heap1 = [5, 12].toHeapQueue
assert heap1.pushpop(6) == 5
assert heap1.len == 2
assert heap1[0] == 6
assert heap1.pushpop(4) == 4 # push() -> pop()
assert heap1.replace(5) == 6 # pop() -> push()

## lists
import std/lists

var list = initDoublyLinkedList[int]()
let
  a2 = newDoublyLinkedNode[int](3)
  b2 = newDoublyLinkedNode[int](7)
  c2 = newDoublyLinkedNode[int](9)

list.add(a2)
list.add(b2)
list.prepend(c2)
assert a2.next == b2
assert a2.prev == c2
assert c2.next == a2
assert c2.next.next == b2
assert c2.prev == nil
assert b2.next == nil

var ring = initSinglyLinkedRing[int]()
let
  a3 = newSinglyLinkedNode[int](3)
  b3 = newSinglyLinkedNode[int](7)
  c3 = newSinglyLinkedNode[int](9)

ring.add(a3)
ring.add(b3)
ring.prepend(c3)
assert c3.next == a3
assert a3.next == b3
assert c3.next.next == b3
assert b3.next == c3
assert c3.next.next.next == c3

let x = [1, 2, 3, 4].toSinglyLinkedList
assert $x == "[1, 2, 3, 4]"

from std/sequtils import toSeq
var x1 = [1, 2, 3].toSinglyLinkedList
let x2 = [4, 5].toSinglyLinkedList
x1.add(x2)
assert x1.toSeq == [1, 2, 3, 4, 5]
assert x2.toSeq == [4, 5]
x1.add(x1)
assert x1.toSeq == [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]

var x3 = initDoublyLinkedList[int]()
let n = newDoublyLinkedNode[int](9)
x3.add(n)
x3.add(8)
assert x3.contains(9)
assert x3.contains(8)

type Foo = ref object
  x: int
var
  f = Foo(x: 1)
  a0 = [f].toDoublyLinkedList
let b0 = a0.copy
a0.add([f].toDoublyLinkedList)
assert a0.toSeq == [f, f]
assert b0.toSeq == [f]
f.x = 42
assert a0.head.next.value.x == 42
assert b0.head.value.x == 42
let c0 = [1, 2, 3].toDoublyLinkedList
assert $c0 == $c0.copy

let x4 = [9, 8].toSinglyLinkedList
assert x4.find(9).value == 9
assert x4.find(1) == nil

var a4 = [4, 5].toSinglyLinkedList
var b4 = [1, 2, 3].toSinglyLinkedList
a4.prepend(b4)
assert a4.toSeq == [1, 2, 3, 4, 5]
assert b4.toSeq == [1, 2, 3]
a4.prepend(a4)
assert a4.toSeq == [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]

var x5 = [0, 1, 2].toSinglyLinkedList
var n1 = x5.head.next
assert n1.value == 1
x5.remove(n1)
assert x5.toSeq == [0, 2]

var a5 = initDoublyLinkedList[int]()
for i in 1..5:
  a5.add(10*i)
assert $a5 == "[10, 20, 30, 40, 50]"
for x in nodes(a5):
  if x.value == 30:
    a5.remove(x)
  else:
    x.value = 5*x.value - 1
assert $a5 == "[49, 99, 199, 249]"

## options
import std/options

proc find(haystack: string, needle: char): Option[int] =
  for i, c in haystack:
    if c == needle:
      return some(i)
  return none(int)

let found = "abc".find('c')
assert found.isSome and found.get() == 2
let found1 = "ab".find('c')
assert found1.isNone

proc isEven(x: int): bool =
  return x mod 2 == 0
assert some(42).filter(isEven) == some(42)
assert none(int).filter(isEven) == none(int)
assert some(-11).filter(isEven) == none(int)

proc doublePositives(x: int): Option[int] =
  if x > 0:
    return some(2*x)
  else:
    return none(int)
assert some(42).flatMap(doublePositives) == some(84)
assert none(int).flatMap(doublePositives) == none(int)
assert some(-11).flatMap(doublePositives) == none(int)

assert some(42).get(999) == 42
assert none(int).get(999) == 999
assert some(42).map(isEven) == some(true)
assert none(int).map(isEven) == none(bool)

type Foo1 = ref object
  a: int
  b: string
assert option[Foo1](nil).isNone
assert option(42).isSome

## packedsets
import std/packedsets

var
  a6 = [1, 2].toPackedSet
  b6 = [2, 3].toPackedSet
  c6 = [3, 4].toPackedSet
assert disjoint(a6, b6) == false
assert disjoint(a6, c6) == true
c6.excl(3)
c6.excl(99)
assert len(c6) == 1
c6 = intersection(a6, b6)
assert c6.len == 1
assert c6 == [2].toPackedSet

var c5 = initPackedSet[int]()
assert c5.isNil
c5.incl(2)
assert not c5.isNil
c5.excl(2)
assert c5.isNil
c5 = symmetricDifference(a6, b6)
assert c5.len == 2
assert c5 == [1, 3].toPackedSet
c5 = union(a6, b6)
assert c5.len == 3
assert c5 == [1, 2, 3].toPackedSet

## sets
import std/sets

let
  s1 = toHashSet([9, 5, 1])
  s2 = toHashSet([3, 5, 7])

echo s1+s2
echo s1-s2
echo s1*s2
echo s1-+-s2

## strtabs
import std/strtabs

var t = newStringTable()
t["name"] = "John"
t["city"] = "Monaco"
assert t.len == 2
assert t.hasKey "name"
assert "name" in t
echo t["city"]

var t1 = {"name": "John", "city": "Monaco"}.newStringTable
var t2 = newStringTable(modeStyleInsensitive)
t2["first_name"] = "John"
t2["LastName"] = "Doe"
assert t2["firstName"] == "John"
assert t2["lastName"] == "Doe"
assert "${name} lives in ${city}" % t1 == "John lives in Monaco"
doAssertRaises(KeyError):
  echo t1["occupation"]
t1["occupation"] = "teacher"
assert t1.hasKey("occupation")
t1.del("name")
assert "name" notin t1
assert t1.getOrDefault("name", "Paul") == "Paul"

## tables
import std/tables

var
  a7 = {1: "one", 2: "two"}.toTable
  b7 = a7
assert a7 == b7
b7[3] = "three"
assert 3 notin a7
assert 3 in b7
assert a7 != b7

var
  a8 = {1: "one", 2: "two"}.newTable
  b8 = a8
assert a8 == b8
b8[3] = "three"
assert 3 in a8
assert 3 in b8
assert a8 == b8

from std/sequtils import zip
let
  names = ["John", "Paul", "George", "Ringo"]
  years = [1940, 1942, 1943, 1940]

var beatles = initTable[string, int]()
for pairs in zip(names, years):
  let (name, birthYear) = pairs
  beatles[name] = birthYear

assert beatles == {"John": 1940, "Paul": 1942, "George": 1943,
    "Ringo": 1940}.toTable

var beatlesByYear = initTable[int, seq[string]]()
for pairs in zip(years, names):
  let (birthYear, name) = pairs
  if not beatlesByYear.hasKey(birthYear):
    beatlesByYear[birthYear] = @[]
  beatlesByYear[birthYear].add(name)

assert beatlesByYear == {1940: @["John", "Ringo"], 1942: @["Paul"], 1943: @[
    "George"]}.toTable

let
  c8 = [('z', 1), ('y', 2), ('x', 3)]
  ot = c8.toOrderedTable
assert $ot == """{'z': 1, 'y': 2, 'x': 3}"""

let myString = "abracadabra"
let letterFrequencies = toCountTable(myString)
assert $letterFrequencies == "{'a': 5, 'd': 1, 'b': 2, 'r': 2, 'c': 1}"

import std/hashes
type
  Person = object
    firstName: string
    lastName: string

proc hash(x: Person): Hash =
  return x.firstName.hash !& x.lastName.hash

var
  salaries = initTable[Person, int]()
  p1: Person
  p2: Person

p1.firstName = "Jon"
p1.lastName = "Ross"
salaries[p1] = 30_000

p2.firstName = "Mark"
p2.lastName = "Adair"
salaries[p2] = 45_000

var x6 = {'a': 5, 'b': 9}.newOrderedTable
if x6.hasKeyOrPut('a', 50):
  x6['a'] = 99
if x6.hasKeyOrPut('z', 50):
  x6['z'] = 99
assert x6 == {'a': 99, 'b': 9, 'z': 50}.newOrderedTable

var
  x7 = {'a': 5, 'b': 9, 'c': 13}.newTable
  i: int
assert x7.pop('b', i) == true
assert x7 == {'a': 5, 'c': 13}.newTable
assert i == 9
i = 0
assert x7.pop('z', i) == false
assert x7 == {'a': 5, 'c': 13}.newTable
assert i == 0

let x8 = {
  'o': @[1, 5, 7, 9],
  'e': @[2, 4, 6, 8]
  }.newOrderedTable

for k in x8.keys:
  x8[k].add(99)
assert x8 == {'o': @[1, 5, 7, 9, 99], 'e': @[2, 4, 5, 8, 99]}.newOrderedTable

