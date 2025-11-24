# This is a module with basic math operations

## add two numbers
proc add*(a: int, b: int): int =
  return a+b

## multiplies two numbers
proc multiply*(a: int, b: int): int =
  return a*b

## calculates factorial of a number
proc factorial*(n: int): int =
  if n <= 1:
    return 1
  return n * factorial(n-1)

# private procedures
proc internalHelper(x: int): int =
  return x*x

## calculates square of a number
proc square*(n: int): int =
  return internalHelper(n)
