# single line comment

#[
  multiline
  comment
]#

discard """
this can also work as a multiline comment.
OR for unparsable, broken code
"""

var
  letter: char = 'n'
  lang = "N" & "im"
  nLength: int = len(lang)
  boat: float
  truth: bool = false

let
  legs = 400
  arms = 2_000_000
  aboutPi = 3.1416

# computed at compile time
const
  debug = true
  compileBadCode = false

# compile time equivalent of if
when compileBadCode:
  legs = legs + 1
  const input = readLine(stdin)

discard 1 > 2

echo "Hello World"

######################
### Data Structure ###
######################

# Tuples
var
  child: tuple[name: string, age: int]
  today: tuple[sun: string, temp: float]

child = (name: "Rudiger", age: 2)
today.sun = "Overcast"
today[1] = 70.1

let imposter = ("Rudiger", 2)
assert child == imposter # Two tuples are the same as long as they have the same type and the same contents

# Sequence
var
  drinks: seq[string]

drinks = @["Water", "Juice", "Chocolate"]

drinks.add("Milk")

if "Milk" in drinks:
  echo "We have Milk and ", drinks.len - 1, " other drinks"

let myDrink = drinks[2]
echo drinks

# Defining Custom Types
type
  Name = string
  Age = int
  Person = tuple[name: Name, age: Age]
  AnotherSyntax = tuple
    firstField: string
    secondField: int

var
  john: Person = (name: "John B.", age: 17)
  newage: int = 18

john.age = newage

type
  Cash = distinct int
  Desc = distinct string

var
  money: Cash = 100.Cash
  description = "Interesting".Desc

when compileBadCode:
  john.age = money
  john.name = description

# Object
type
  Room = ref object
    windows: int
    doors: int = 1
  House = object
    address: string
    rooms: seq[Room]

var
  defaultHouse = House()
  defaultRoom = Room()

  # Create and initialize instances with given values
  sesameRoom = Room(windows: 4, doors: 2)
  sesameHouse = House(address: "123 Sesame St.", rooms: @[sesameRoom])

echo sesameHouse

# Enumeration allow a type to have one of a limited number of values
type
  Color = enum cRed, cBlue, cGreen
  Direction = enum
    dNorth
    dWest
    dEast
    dSouth

var
  orient = dNorth
  pixel = cGreen

echo dNorth > dEast

# Subranges specify a limited valid range
type
  DieFaces = range[1..6] # only an int from 1 to 6 is a valid value

var
  my_Roll: DieFaces = 6

echo my_Roll

# Arrays
type
  RollCounter = array[DieFaces, int]
  DirNames = array[Direction, string]
  Truths = array[42..44, bool]

var
  counter: RollCounter
  directions: DirNames
  possible: Truths

possible = [false, false, false]
possible[42] = true

directions[dNorth] = "Ahh. The Great White North!"
directions[dWest] = "No, don't go there."

my_Roll = 5
counter[my_Roll] += 2
counter[my_Roll] += 2

var anotherArray = ["Default index", "starts at", "0"]

###########################
### IO and Control Flow ###
###########################

echo "Read any good books lately?"
case readLine(stdin)
of "no", "No":
  echo "Go to your local library"
of "yes", "Yes":
  echo "Carry on, then."
else:
  echo "That's great; I assume."

import strutils
import strformat

echo "I'm thinking of a number between 41 and 43. Guess which!"
let number: int = 42

var
  raw_guess: string
  guess: int

while guess != number:
  raw_guess = readLine(stdin)
  if raw_guess == "":
    continue
  else:
    guess = strutils.parseInt(raw_guess)
    if guess == 1001:
      echo("AAAAAAGGG!")
    elif guess > number:
      echo("Nope. Too high.")
    elif guess < number:
      echo(guess, " is too low")
    else:
      echo("Yeeeehaw!")

for i, elem in ["Yes", "No", "Maybe so"]:
  echo(elem, " is at index: ", i)

for k, v in items(@[(person: "You", power: 100), (person: "Me", power: 900)]):
  echo(k, ": ", v)

# multiline raw string
let myString = """
an <example>
`string` to
play with"""

for line in splitLines(myString):
  echo line

##################
### Procedures ###
##################

type Answer = enum aYes, aNo

proc ask(question: string): Answer =
  echo(question, " (y/n)")
  while true:
    case readLine(stdin)
    of "y", "Y", "yes", "Yes", "YES":
      return Answer.aYes
    of "n", "N", "no", "No", "NO":
      return Answer.aNo
    else:
      echo("Please be clear: yes or no")

proc addSuger(amount: int = 2) =
  assert(amount > 0 and amount < 9000, "Crazy Sugar")
  for a in 1..amount:
    # echo(a, " suger...")
    echo fmt"{a} suger..."

case ask("Would you like suger in your tea?")
of aYes:
  addSuger(3)
of aNo:
  echo "Oh do take a little!"
  addSuger()

var
  a = "hello"
  b = "world"

echo strutils.join([a, " ", b])
