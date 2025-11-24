# Module A
var
  x*: int = 7
  y: int

proc `*` *(a: seq[int], b: seq[int]): seq[int] =
  #allocate a new sequence
  newSeq(result, len(a))

  for i in 0..<len(a):
    result[i] = a[i]*b[i]

proc print*(a: int): string =
  return "\ncalled by Module A: " & $a
