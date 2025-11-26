import pixels

# when isMainModule:
#   echo("Hello, World!")

# putPixel(5, 9)
# putPixel(11, 18, Red)

type Point = object
  x: int
  y: int

# var p = Point(x: 5, y: 7)
# putPixel(p.x, p.y)

proc drawHorizontalLine(start: Point, length: Positive) =
  for delta in 0..length:
    putPixel(start.x+delta, start.y)

proc drawVerticalLine(start: Point, length: Positive) =
  for delta in 0..length:
    putPixel(start.x, start.y+delta)

let a = Point(x: 60, y: 40)
  # drawHorizontalLine(a, 50)
  # drawVerticalLine(a, 30)

type Direction = enum
  Horizontal
  Vertical

proc drawLine(start: Point, length: Positive, direction: Direction) =
  case direction
  of Horizontal:
    drawHorizontalLine(start, length)
  of Vertical:
    drawVerticalLine(start, length)

drawLine(a, 50, Horizontal)
drawLine(a, 30, Vertical)

proc drawHorizontalLine(a: Point, b: Point) =
  if b.x < a.x:
    drawHorizontalLine(b, a)
  else:
    for x in a.x..b.x:
      putPixel(x, a.y)

proc drawVerticalLine(a: Point, b: Point) =
  if b.y < a.y:
    drawVerticalLine(b, a)
  else:
    for y in a.y..b.y:
      putPixel(a.x, y)

let
  p = Point(x: 20, y: 20)
  q = Point(x: 50, y: 20)
  r = Point(x: 20, y: -10)

drawHorizontalLine(p, q)
drawVerticalLine(p, r)

drawText(130, 140, "Welcome to Nim!", 11, Yellow)

assert($12 == "12")
assert("abc" & "def" == "abcdef")

for i in 1..3:
  let text_to_draw = "welcome to nim for the " & $i & "th time!"
  drawText(200, i*20, text_to_draw, 11, Yellow)

proc putPixels(points: seq[Point], col: Color) =
  for p in items(points):
    pixels.putPixel(p.x, p.y, col)

putPixels(@[Point(x: 200, y: 300), Point(x: 400, y: 500), Point(x: 300,
    y: 400)], Gold)

proc resetPointsToOrigin(points: var seq[Point]) =
  for i in 0..<len(points):
    points[i] = Point(x: 0, y: 0)

var points = @[Point(x: 2, y: 4), Point(x: 20, y: 40)]
resetPointsToOrigin(points)
echo(points)

let points1 = @[Point(x: 2, y: 4)]
  # resetPointsToOrigin(points1) # not possible
  # echo(points1)

iterator `..<`(a: int, b: int): int =
  var i = a
  while i < b:
    yield i
    inc i

iterator Items(s: seq[Point]): Point =
  for i in 0..<len(s):
    yield s[i]

for i in Items(points1):
  echo(i)

proc find(haystack: string, needle: char): int =
  for i in 0..<len(haystack):
    if haystack[i] == needle:
      return i
  return -1

let index = find("abcabc", 'c')
echo(index)

iterator findAll(haystack: string, needle: char): int =
  for i in 0..<len(haystack):
    if haystack[i] == needle:
      yield i

for index in findAll("abcabc", 'c'):
  echo "#", index

iterator Item[T](s: seq[T]): T =
  for i in 0..<len(s):
    yield s[i]

for x in Item(@[1, 2, 3]):
  echo "*", x
for x in Item(@["1", "2", "3"]):
  echo "#", x

type
  Point2[T] = object
    x: T
    y: T

var p2: Point2[float]
p2 = Point2[float](x: 1.0, y: 3.3)
echo(p2)

const
  ScreenWidth = 1024
  ScreenHeight = 768

proc safePutPixel(x: int, y: int, col: Color) =
  if x < 0 or x >= ScreenWidth or y < 0 or y >= ScreenHeight:
    return
  putPixel(x, y, col)

# expand the template's body at the call site
template boundsCheck(a: int, b: int) =
  if a < 0 or a >= ScreenWidth or b < 0 or b >= ScreenHeight:
    return

proc safePutPixel1(x: int, y: int, col: Color) =
  boundsCheck(x, y)
  putPixel(x, y, col)

template wrap(body: untyped) =
  drawText(300, 10, "Before Body", 11, Yellow)
  body

wrap:
  for i in 1..3:
    let textToDraw = "Welcome to Nim for the " & $i & "th time!"
    drawText(500, i*10, textToDraw, 11, Yellow)

template putPixel(x: int, y: int) =
  putPixel(x, y, colorContext)

template drawText(x: int, y: int, s: string, f: int) =
  drawText(x, y, s, f, colorContext)

template withColor(col: Color, body: untyped) =
  let colorContext {.inject.} = col
  body

withColor(Blue):
  putPixel(3, 4)
  drawText(10, 30, "abc", 12)

import std/macros

macro disable(body: untyped): untyped =
  result = newStmtList()

disable:
  drawText(150, 150, "Disable piece of code!", 11, Blue)
