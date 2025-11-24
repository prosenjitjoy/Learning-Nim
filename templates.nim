template `!=`(a: untyped, b: untyped): untyped =
  not(a == b)

assert 5 != 6 # the compiler rewrites that to: assert not(5 == 6)

template `||`(a: untyped, b: untyped): untyped =
  (a or b)

assert (1 || 0) == 1

const debug = true

template log(msg: string) =
  if debug:
    stdout.writeLine(msg)

var x = 4
log("x has the value: " & $x)

template withFile(f: untyped, filename: string, mode: FileMode, body: untyped) =
  let fn = filename
  var f: File
  if open(f, fn, mode):
    try:
      body
    finally:
      close(f)
  else:
    quit("Cannot open: " & fn)

withFile(txt, "template.txt", fmWrite):
  txt.writeLine("Line 1")
  txt.writeLine("Line 2")
