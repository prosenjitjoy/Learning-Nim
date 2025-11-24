from std/strutils import parseInt
from std/strformat import fmt

## raise statement
# var
#   e: ref OSError
# new(e)
# e.msg = "the request to the OS failed"

# raise e
# raise newException(OSError, "the request to the OS failed")

var
  f: File
if open(f, "numbers.txt"):
  try:
    let a = readLine(f)
    let b = readLine(f)
    echo "sum: ", parseInt(a) + parseInt(b)
  except OverflowDefect:
    echo "overflow"
  except ValueError:
    echo "could not convert string to integer"
  except IOError:
    echo "IO error"
  except CatchableError:
    let e = getCurrentException()
    let msg = getCurrentExceptionMsg()
    echo fmt"Got exception {repr(e)} with message {msg}"
    raise
  finally:
    close(f)

## annotating procs with raised exceptions
# proc complexProc() {.raises: [IOError, ArithmeticDefect].} =
#   ...

# proc simpleProc() {.raises: [].} =
#   ...
