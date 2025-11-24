# This module is in a subdirectory
import std/strformat

proc formatResult*(operation: string, a: int, b: int, res: int): string =
  return fmt"'{operation}': {a} and {b} = {res}"

proc isEven*(n: int): bool =
  return (n mod 2) == 0
