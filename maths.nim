## math
import std/math

assert ceil(2.1) == 3.0
assert ceil(-2.1) == -2.0
assert floor(2.0) == 2.0
assert floor(-2.1) == -3.0
assert round(3.4) == 3.0
assert round(3.5) == 4.0

assert almostEqual(cbrt(8.0), 2.0)
assert almostEqual(cbrt(-27.0), -3.0)
assert almostEqual(sqrt(4.0), 2.0)
assert almostEqual(cos(2*PI), 1.0)
assert almostEqual(cosh(0.0), 1.0)
assert almostEqual(degToRad(180.0), PI)
assert almostEqual(radToDeg(2*PI), 360.0)
assert almostEqual(ln(1.0), 0.0)

assert fac(4) == 24
assert sum([-4, 3, 5]) == 4
assert cumsummed([1, 2, 3, 4]) == @[1, 3, 6, 10]
assert gcd(12, 8) == 4
assert isPowerOfTwo(16)
assert not isPowerOfTwo(5)
assert not isPowerOfTwo(-16)
assert lcm(24, 30) == 120
assert 6.5 mod 2.5 == 1.5
assert nextPowerOfTwo(16) == 16
assert nextPowerOfTwo(5) == 8

## random
import std/random
import std/terminal

#seed
randomize()

let num = rand(100)
assert num in 0..100

let roll = rand(1..6)
assert roll in 1..6

let marbles = ["red", "blue", "green", "yellow", "purple"]
let pick = sample(marbles)
assert pick in marbles

let colors = [fgRed, fgGreen, fgYellow, fgBlue, fgMagenta, fgCyan]
let color = sample(colors)
stdout.styledWriteLine(color, "This is a random color text.")
assert color in colors

var cards = ["Ace", "King", "Queen", "Jack", "Ten"]
shuffle(cards)
assert cards.len == 5
echo cards

var r = initRand(365)
assert r.rand(1..5) <= 5
assert r.rand(-1.1..1.2) >= -1.1

randomize(365)
assert rand(1..6) <= 6

type E = enum a, b, c, d
assert rand(E) in a..d
assert rand(char) in low(char)..high(char)
assert rand(int8) in low(int8)..high(int8)
assert rand(uint32) in low(uint32)..high(uint32)
assert rand(range[1..16]) in 1..16

## stats
import std/stats

template `~=`(a: float, b: float): bool =
  almostEqual(a, b)

var statistics: RunningStat
statistics.push(@[1.0, 2.0, 1.0, 4.0, 1.0, 4.0, 1.0, 2.0])
assert statistics.n == 8
assert statistics.mean() ~= 2.0
echo statistics.variance()
echo statistics.varianceS()
echo statistics.skewness()
echo statistics.skewnessS()
echo statistics.kurtosis()
echo statistics.kurtosisS()

## sysrand
import std/sysrand

assert urandom(0).len == 0
assert urandom(8).len == 8
assert urandom(1234) != urandom(1234)
