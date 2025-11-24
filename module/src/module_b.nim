# Module B
var
  x*: int = 6
  y*: int = 10

proc print*(a: string): string =
  return "\ncalled by Module B: " & a
