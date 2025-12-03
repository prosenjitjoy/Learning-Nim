## algorithm
import std/algorithm

type People = tuple
  year: int
  name: string

var a: seq[People]
a.add((2005, "Marie"))
a.add((2000, "John"))
a.add((2010, "Jane"))

echo a
a.sort()
assert a == @[(2000, "John"), (2005, "Marie"), (2010, "Jane")]

proc myCmp(x: People, y: People): int =
  cmp(x.name, y.name)
a.sort(myCmp)
echo a
assert a == @[(2010, "Jane"), (2000, "John"), (2005, "Marie")]

let
  b = [1, 2, 3, 4, 5]
  c = [5, 4, 3, 2, 1]
  d = ["adam", "dande", "brain", "cat"]

assert isSorted(b) == true
assert isSorted(c, Descending) == true
assert isSorted(d) == false

var arr = @[1, 2, 3, 5, 6, 7, 8, 9]
assert arr.upperBound(2, cmp[int]) == 2
assert arr.upperBound(3, cmp[int]) == 3
assert arr.upperBound(4, cmp[int]) == 3

assert arr.lowerBound(3, cmp[int]) == 2
assert arr.lowerBound(4, cmp[int]) == 3
assert arr.lowerBound(5, cmp[int]) == 3

var ar: array[6, int]
ar.fill(1, 3, 9)
assert ar == [0, 9, 9, 9, 0, 0]
ar.fill(3, 5, 7)
assert ar == [0, 9, 9, 7, 7, 7]

assert binarySearch(["a", "b", "c", "d"], "d", cmp[string]) == 3
assert binarySearch(["a", "b", "c", "d"], "c", cmp[string]) == 2
assert binarySearch([0, 1, 2, 3, 4], 4) == 4
assert binarySearch([0, 1, 2, 3, 4], 2) == 2

## enumutils
import std/enumutils

type B = enum
  b0 = (10, "kb0")
  b1 = "kb1"
  b2

let a1 = B.low
assert a1.symbolName == "b0"
echo a1
assert $a1 == "kb0"

## sequtils
import std/sequtils
import std/strutils

let
  vowels = @"aeiou"
  foo = "sequtils is an awesome module"

assert vowels is seq[char]
assert vowels == @['a', 'e', 'i', 'o', 'u']
assert foo.filterIt(it notin vowels).join == "sqtls s n wsm mdl"

let
  myRange = 1..5
  mySet = {5'i8, 3, 1}
assert typeof(myRange) is HSlice[int, int]
assert typeof(mySet) is set[int8]

let
  mySeq1 = toSeq(myRange)
  mySeq2 = toSeq(mySet)
assert mySeq1 == @[1, 2, 3, 4, 5]
assert mySeq2 == @[1'i8, 3, 5]

var seq2d = newSeqWith(5, newSeq[bool](3))
assert seq2d.len == 5
assert seq2d[0].len == 3
assert seq2d[4][2] == false

# creates a seq with random numbers
import std/random
var seqRand = newSeqWith(20, rand(1.0))
assert seqRand[0] != seqRand[1]
echo seqRand

let
  nums = @[1, 2, 3, 4]
  strings = nums.mapIt($(4*it))
assert strings == @["4", "8", "12", "16"]

var candidates = @["foo", "bar", "baz", "foobar"]
candidates.keepItIf(it.len == 3 and it[0] == 'b')
assert candidates == @["bar", "baz"]

let
  temperatures = @[-272.15, -2.0, 24.5, 44.31, 99.9, -113.44]
  acceptable = temperatures.filterIt(it < 50 and it > -10)
  notAcceptable = temperatures.filterIt(it > 50 or it < -10)
assert acceptable == @[-2.0, 24.5, 44.31]
assert notAcceptable == @[-272.15, 99.9, -113.44]

let numbers = @[-3, -2, -1, 0, 1, 2, 3, 4, 5, 6]
iterator iota(n: int): int =
  for i in 0..<n:
    yield i
assert numbers.countIt(it < 0) == 3
assert countIt(iota(10), it < 2) == 2

var nums1 = @[1, 2, 3, 4]
nums1.applyIt(it * 3)
assert nums1[0] + nums1[3] == 15

let nums2 = @[1, 4, 5, 8, 9, 7, 4]
assert nums2.anyIt(it > 8) == true
assert nums2.anyIt(it > 9) == false
assert nums2.allIt(it < 10) == true
assert nums2.allIt(it < 9) == false

let a3 = mapLiterals((1.2, (2.3, 3.4), 4.8), int)
let b3 = mapLiterals((1.2, (2.3, 3.4), 4.8), int, nested = false)
assert a3 == (1, (2, 3), 4)
assert b3 == (1, (2.3, 3.4), 4)

let c3 = mapLiterals((1, (2, 3), 4, (5, 6)), `$`)
let d3 = mapLiterals((1, (2, 3), 4, (5, 6)), `$`, nested = false)
assert c3 == ("1", ("2", "3"), "4", ("5", "6"))
assert d3 == ("1", (2, 3), "4", (5, 6))

let nums3 = @[1, 4, 5, 8, 9, 7, 4]
var evens = newSeq[int]()
for n in filter(nums3, proc (x: int): bool = x mod 2 == 0):
  evens.add(n)
assert evens == @[4, 8, 4]

let total = repeat(5, 3)
assert total == @[5, 5, 5]

let
  s1 = @[1, 3, 6, -4]
  s2 = @["foo", "bar", "hello"]

assert minIndex(s1) == 3
assert minIndex(s2) == 1
assert maxIndex(s1) == 2
assert maxIndex(s2) == 2

let s3 = map(s1, proc(x: int): string = $x)
assert s3 == @["1", "3", "6", "-4"]

var floats = @[13.0, 12.5, 5.8, 2.0, 6.1, 9.9, 10.1]
keepIf(floats, proc(x: float): bool = x > 10)
assert floats == @[13.0, 12.5, 10.1]

var dest = @[1, 1, 1, 1, 1, 1, 1, 1]
let
  src = @[2, 2, 2, 2, 2, 2]
  outcome = @[1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1]
dest.insert(src, 3)
assert dest == outcome

let
  colors = @["red", "yellow", "black"]
  f1 = filter(colors, proc(x: string): bool = x.len < 6)
  f2 = filter(colors, proc(x: string): bool = x.contains('y'))
assert f1 == @["red", "black"]
assert f2 == @["yellow"]

var a4 = @[10, 11, 12, 13, 14]
a4.delete(4..4)
assert a4 == @[10, 11, 12, 13]
a4.delete(1..2)
assert a4 == @[10, 13]

let
  dup1 = @[1, 1, 3, 4, 2, 2, 8, 1, 4]
  dup2 = @["a", "a", "c", "d", "d"]
  unique1 = deduplicate(dup1)
  unique2 = deduplicate(dup2, isSorted = true)
assert unique1 == @[1, 3, 4, 2, 8]
assert unique2 == @["a", "c", "d"]

let
  s4 = @[1, 2, 3]
  total1 = s4.cycle(3)
assert total1 == @[1, 2, 3, 1, 2, 3, 1, 2, 3]

let
  a5 = @[1, 2, 2, 3, 2, 4, 2]
  b5 = "abracadabra"
assert count(a5, 2) == 4
assert count(a5, 99) == 0
assert count(b5, 'r') == 2

let
  s5 = @[1, 2, 3]
  s6 = @[4, 5]
  s7 = @[6, 7]
  total2 = concat(s5, s6, s7)
assert total2 == @[1, 2, 3, 4, 5, 6, 7]

var a6 = @["1", "2", "3", "4"]
apply(a6, proc(x: var string) = x &= "42")
assert a6 == @["142", "242", "342", "442"]

let numbers1 = @[1, 4, 5, 8, 9, 7, 4]
assert any(numbers1, proc(x: int): bool = x > 8) == true
assert any(numbers1, proc(x: int): bool = x > 9) == false
assert all(numbers1, proc(x: int): bool = x < 10) == true
assert all(numbers1, proc(x: int): bool = x < 9) == false

var a7 = @[1, 2, 3]
a7.addUnique(4)
a7.addUnique(4)
assert a7 == @[1, 2, 3, 4]

## setutils
import std/setutils

assert {1, 2, 3} -+- {2, 3, 4} == {1, 4}

type A = enum
  e0, e1, e2, e3

var s8 = {e0, e3}
s8[e0] = false
s8[e1] = false
assert s8 == {e3}
s8[e2] = true
s8[e3] = true
assert s8 == {e2, e3}

type Colors = enum
  red, green = 3, blue
assert complement({red, blue}) == {green}
echo complement({blue}), ord(red), ord(blue)
assert complement({red, green, blue}).card == 0

assert bool.fullSet == {true, false}
type C = range[1..3]
assert C.fullSet == {1.C, 2, 3}
assert int8.fullSet.len == 256

assert symmetricDifference({1, 2, 3}, {2, 3, 4}) == {1, 4}
var xx = {1, 2, 3}
xx.toggle({2, 3, 4})
assert xx == {1, 4}

assert "helloWorld".toSet == {'W', 'd', 'e', 'h', 'l', 'o', 'r'}
assert toSet([10'u16, 20, 30]) == {10'u16, 20, 30}
assert [30'u8, 100, 10].toSet == {10'u8, 30, 100}
assert toSet(@[1321'i16, 321, 90]) == {90'i16, 321, 1321}
assert toSet([false]) == {false}
assert toSet(0'u8..10) == {0'u8..10}
