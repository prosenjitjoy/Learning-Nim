## cstrutils
import std/cstrutils

assert cmpIgnoreCase(cstring"Hello", cstring"HeLLo") == 0
assert cmpIgnoreCase(cstring"echo", cstring"hello") < 0
assert cmpIgnoreCase(cstring"yellow", cstring"hello") > 0
assert cmpIgnoreStyle(cstring"hello", cstring"h_e_L_L_o") == 0
assert endsWith(cstring"Hello, Nimion", cstring"Nimion")
assert not endsWith(cstring"Hello, Nimion", cstring"Hello")
assert endsWith(cstring"Hello", cstring"")
assert startsWith(cstring"Hello, Nimion", cstring"Hello")
assert not startsWith(cstring"Hello, Nimion", cstring"Nimion")
assert startsWith(cstring"Hello", cstring"")

## editdistance
import std/editdistance

assert editDistance("Kitten", "Bitten") == 1
echo editDistance("kitten", "beaten")

## formatfloat
import std/formatfloat

var
  s = "foo:"
  f = 45.67
s.addFloat(f)
assert s == "foo:45.67"

## strbasics
import std/strbasics

var a = "  vhellov   "
strip(a)
assert a == "vhellov"
a = "   vhellov    "
a.strip(leading = false)
assert a == "   vhellov"

var b = "blaXbla"
b.strip(chars = {'b', 'a'})
assert b == "laXbl"

## strformat
import std/strformat

assert &"""{"abc":>4}""" == " abc"
assert &"""{"abc":<4}""" == "abc "

assert fmt"{-12345:08}" == "-0012345"
assert fmt"{-1:3}" == " -1"
assert fmt"{-1:03}" == "-01"
assert fmt"{16:#X}" == "0x10"

assert fmt"{123.456}" == "123.456"
assert fmt"{123.456:>9.3f}" == "  123.456"
assert fmt"{123.456:9.3f}" == "  123.456"
assert fmt"{123.456:9.4f}" == " 123.4560"
assert fmt"{123.456:>9.0f}" == "     123."
assert fmt"{123.456:<9.4f}" == "123.4560 "

assert fmt"{123.456:e}" == "1.234560e+02"
assert fmt"{123.456:>13e}" == " 1.234560e+02"
assert fmt"{123.456:13e}" == " 1.234560e+02"

let x = "12"
assert fmt"{x=}" == "x=12"
assert fmt"{x =:}" == "x =12"
assert fmt"{x =}" == "x =12"
assert fmt"{x= :}" == "x= 12"
assert fmt"{x= }" == "x= 12"
assert fmt"{x = :}" == "x = 12"
assert fmt"{x = }" == "x = 12"
assert fmt"{x   =  :}" == "x   =  12"
assert fmt"{x   =  }" == "x   =  12"

## strutils
import std/strutils

let
  numbers = @[867, 5309]
  multiLineString = "first line\nsecond line\nthird line"

let jenny = numbers.join("-")
assert jenny == "867-5309"
assert splitLines(multiLineString) == @["first line", "second line", "third line"]
assert split(multiLineString) == @["first", "line", "second", "line", "third", "line"]
assert 'z'.repeat(5) == "zzzzz"

from std/sequtils import map
assert jenny.split('-').map(parseInt) == numbers

assert align("abc", 4) == " abc"
assert align("a", 0) == "a"
assert align("1232", 6) == "  1232"
assert align("1232", 6, '#') == "##1232"

assert alignLeft("abc", 4) == "abc "
assert alignLeft("a", 0) == "a"
assert alignLeft("1232", 6) == "1232  "
assert alignLeft("1232", 6, '#') == "1232##"

assert allCharsInSet("ea", {'a', 'e'}) == true
assert capitalizeAscii("foo") == "Foo"
assert capitalizeAscii("-bar") == "-bar"

var a1 = "abracadabra"
assert a1.continuesWith("ca", 4) == true
assert a1.continuesWith("ca", 5) == false
assert a1.continuesWith("dab", 6) == true

a1.delete(1..2)
assert a1 == "aacadabra"
assert a1.endsWith("dabra") == true
assert a1.endsWith("dab") == false

assert intToStr(1984) == "1984"

assert isAlphaAscii('e') == true
assert isAlphaAscii('8') == false

assert isAlphaNumeric('e') == true
assert isAlphaNumeric('8') == true
assert isAlphaNumeric(' ') == false

assert isDigit('n') == false
assert isDigit('8') == true

assert isLowerAscii('e') == true
assert isLowerAscii('E') == false
assert isLowerAscii('8') == false

assert isSpaceAscii('n') == false
assert isSpaceAscii(' ') == true
assert isSpaceAscii('\t') == true

assert isUpperAscii('e') == false
assert isUpperAscii('E') == true
assert isUpperAscii('7') == false

assert join([1, 2, 3], " -> ") == "1 -> 2 -> 3"
assert normalize("Foo_bar Baz") == "foobar baz"

type MyEnum = enum
  first = "1st"
  second
  third = "3rd"
assert parseEnum[MyEnum]("1_st") == first
assert parseEnum[MyEnum]("second") == second
doAssertRaises(ValueError):
  echo parseEnum[MyEnum]("third")

assert parseFloat("3.14159") == 3.14159
assert parseInt("-0042") == -42

var ident = "pControl"
ident.removePrefix('p')
assert ident == "Control"
var userInput = "\r\n*~Hello World!"
userInput.removePrefix
assert userInput == "*~Hello World!"
userInput.removePrefix({'~', '*'})
assert userInput == "Hello World!"

var table = "users"
table.removeSuffix('s')
assert table == "user"
var dots = "Trailing dots...."
dots.removeSuffix('.')
assert dots == "Trailing dots"
var otherInput = "Hello!?!"
otherInput.removeSuffix({'!', '?'})
assert otherInput == "Hello"

assert "a,b,c".split(',') == @["a", "b", "c"]
