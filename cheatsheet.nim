## integers
assert 13 div 5 == 2
assert 13 mod 5 == 3
assert 1 shl 3 == 8
assert 8 shr 1 == 4
assert (0b0011 and 0b0101) == 0b0001
assert (0b0011 or 0b0101) == 0b0111
assert (0b0011 xor 0b0101) == 0b0110
assert toInt(2.49) == 2
assert toInt(2.5) == 3

var x = 5
inc x
assert x == 6
inc x, 3
assert x == 9

var y = 5
dec y
assert y == 4
dec y, 3
assert y == 1

## strings
import std/strutils

assert $123 == "123"
assert "ab" & "cd" == "abcd"
assert ["ab", "cd", "ef"].join("-x-") == "ab-x-cd-x-ef"
assert split("ab cd") == @["ab", "cd"]
assert "abxcd".split('x') == @["ab", "cd"]
assert "abcd".find('c') == 2
assert "abcd".find("bc") == 1
assert "acdc".replace('c', 'x') == "axdx"

## sequences
import std/sequtils

assert toSeq(1..3) == @[1, 2, 3]
assert @"abc" == @['a', 'b', 'c']
assert (@[1, 2] & @[3, 4]) == @[1, 2, 3, 4]

proc double(x: int): int =
  return x*2

var a = @[1, 3, 5]
var b = a.map(double)
assert b == @[2, 6, 10]

proc small(x: int): bool =
  return x < 4

var p = @[1, 3, 5]
var q = p.filter(small)
assert q == @[1, 3]

## bit sets
var a1 = {5..8}
a1.incl(3)
assert a1 == {3, 5, 6, 7, 8}

var a2 = {5..8}
a2.excl(5)
assert a2 == {6, 7, 8}
assert {1, 2}*{2, 3} == {2}
assert {1, 2}-{2, 3} == {1}
assert {1, 2} < {1, 2, 3}
assert not({1, 2} < {1, 2})

## hash sets
import std/sets

assert toHashSet("acdc") == ['a', 'c', 'd'].toHashSet
var a3 = [1, 2].toHashSet
var b3 = [2, 3].toHashSet
var c3 = [1, 2, 3].toHashSet

assert a3*b3 == [2].toHashSet
assert a3+b3 == [1, 2, 3].toHashSet
assert a3-b3 == [1].toHashSet
assert b3-a3 == [3].toHashSet
assert a3 < c3
assert not(a3 < a3)
assert card([1, 2].toHashSet) == 2

let x1 = c3.pop
assert card(c3) == 2
assert a3.containsOrIncl(1)
assert not a3.containsOrIncl(9)
assert a3 == [1, 2, 9].toHashSet

## hash tables
import std/tables

var x3 = initTable[int, string]()
var x4 = toTable([(5, "ab"), (7, "cd")])
x4[9] = "ef"
echo x4[5]
# echo x4[1] #key error
echo x4.getOrDefault(9)
echo x4.getOrDefault(2)
echo x4.getOrDefault(1, "xz")
assert x4.hasKey(5)

echo x4.hasKeyOrPut(1, "yz")
x4.del(9)
echo x4

## string formatting
import std/strformat

let msg = "hello"
echo fmt"{msg}\n"
echo &"{msg}\n"
let s = "nim"
let z = 987.12

assert fmt"{s:5}" == "nim  "
assert fmt"{s:<5}" == "nim  "
assert fmt"{s:>5}" == "  nim"
assert fmt"{s:^5}" == " nim "
assert fmt"{z:8.2f}" == "  987.12"
assert fmt"{z:8.4f}" == "987.1200"
assert fmt"{z:<8.1f}" == "987.1   "
assert fmt"{s=}" == "s=nim"
assert fmt"{s = }" == "s = nim"

## algorithms
import std/algorithm

var a5 = [50, 60, 70, 80]
assert a5.binarySearch(70) == 2

var a6: array[5, int]
a6.fill(2, 4, 99)
assert a6 == [0, 0, 99, 99, 99]
a6.fill(88)
assert a6 == [88, 88, 88, 88, 88]

var a7 = [10, 20, 30, 40, 50, 60]
a7.reverse(1, 3)
assert a7 == [10, 40, 30, 20, 50, 60]
a7.reverse()
assert a7 == [60, 50, 20, 30, 40, 10]

var a8 = [10, 20, 30, 40]
assert a8.nextPermutation() == true
assert a8 == [10, 20, 40, 30]

var a9 = [40, 30, 20, 10]
assert a9.nextPermutation() == false
assert a9 == [40, 30, 20, 10]

var p1 = @[10, 20, 30]
var q1 = @[99, 88]

assert product([p1, q1]) == @[@[30, 88], @[20, 88], @[10, 88],
@[30, 99], @[20, 99], @[10, 99], ]

var a10 = [20, 40, 50, 10, 30]
assert sorted(a10) == @[10, 20, 30, 40, 50]
a10.sort(Descending)
assert a10 == [50, 40, 30, 20, 10]

## os
import std/os

assert joinPath("foo", "bar") == "foo/bar"
assert "foo" / "bar" == "foo/bar"
assert addFileExt("foo", "bar") == "foo.bar"
assert addFileExt("foo.exe", "bar") == "foo.exe"
assert changeFileExt("foo", "bar") == "foo.bar"
assert changeFileExt("foo.exe", "bar") == "foo.bar"
assert changeFileExt("foo.exe", "") == "foo"
assert execShellCmd("ls -la") == 0
assert extractFilename("foo/bar/baz.exe") == "baz.exe"
assert extractFilename("foo/bar/") == ""
assert parentDir("foo/bar/baz.exe") == "foo/bar"
assert parentDir("foo/bar/") == "foo"
assert splitFile("foo/bar/baz.exe") == ("foo/bar", "baz", ".exe")
assert splitFile("foo/bar/") == ("foo/bar", "", "")
echo paramCount()
echo paramStr(1)
