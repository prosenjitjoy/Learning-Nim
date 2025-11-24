import unittest
import ../src/math_operations
import ../src/utils/helpers

suite "Math Operations Tests":
  test "addition":
    check add(2, 3) == 5
    check add(-1, 1) == 0

  test "multiplication":
    check multiply(4, 5) == 20
    check multiply(0, 100) == 0

  test "factorial":
    check factorial(0) == 1
    check factorial(6) == 720

suite "Helper Tests":
  test "isEven":
    check isEven(4) == true
    check isEven(7) == false
