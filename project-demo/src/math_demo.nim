import math_operations
import utils/helpers
import std/strformat

# can also use selective import
# from math_operations import factorial

proc demonstrateModules() =
  echo "=== Math Operations Demo ==="

  let x: int = 5
  let y: int = 3

  echo "\nUsing math_operations module:"
  echo "  ", formatResult("Addition", x, y, add(x, y))
  echo "  ", formatResult("Multiplication", x, y, multiply(x, y))

  echo fmt"  Factorial of {x} is {factorial(x)}"

  echo "\nUsing helpers module:"
  echo fmt"  Is {x} even? {isEven(x)}"
  echo fmt"  Is {y} even? {isEven(y)}"

  let sumResult: int = add(x, y)
  echo "\nChaining operations:"
  echo fmt"  Sum of {x} and {y} is {sumResult}"
  echo fmt"  Is the sum even? {isEven(sumResult)}"

when isMainModule:
  demonstrateModules()
