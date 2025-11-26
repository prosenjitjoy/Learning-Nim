proc worker(s: string) {.thread.} =
  echo s

var background: Thread[string]
createThread(background, worker, "abc")
echo "xyz"
joinThread(background)
echo "control flow converged"

## single worker, single channel
var chan: Channel[string]
chan.open()

proc worker1() {.thread.} =
  while true:
    let task = chan.recv()
    if len(task) == 0:
      break
    echo task

proc log(msg: string) =
  chan.send(msg)

var logger: Thread[void]
createThread(logger, worker1)
log("a")
log("b")
log("c")
log("")
joinThread(logger)
chan.close()

## multiple workers, single channel
chan.open()
proc worker2(threadIndex: int) {.thread.} =
  while true:
    let task = chan.recv()
    if len(task) == 0:
      break
    echo("Thread ", threadIndex, ": ", task)

proc log2(msg: string) =
  chan.send(msg)

var loggers: array[4, Thread[int]]
for i in 0..<len(loggers):
  createThread(loggers[i], worker2, i)

log2("a")
log2("b")
log2("c")
for i in 0..<len(loggers):
  log2("")

joinThreads(loggers)
chan.close
