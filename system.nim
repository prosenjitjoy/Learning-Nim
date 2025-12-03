## system
# strings and characters
var tmp = ""
tmp.add('a')
tmp.add('b')
assert tmp == "ab"
var ch = 'c'
var i = 99
echo ord(ch)
echo chr(i)
echo tmp & $ch

# sequences
var inputString = newSeq[string](3)
assert len(inputString) == 3
inputString[0] = "The fourth"
inputString[1] = "assignment"
inputString[2] = "would crash"
# inputString[3] = "out of bounds"
echo inputString

var x = newSeqOfCap[int](5)
assert len(x) == 0
x.add(10)
assert len(x) == 1

var xx = @[10, 20]
xx.setLen(5)
xx[4] = 50
assert xx == @[10, 20, 0, 0, 50]
xx.setLen(1)
assert xx == @[10]
xx.insert(99, 0)
echo len(xx)
xx.delete(1)
echo xx

var s = @[1, 2, 3, 4]
assert s[0..2] == @[1, 2, 3]
echo s.pop()
echo s

# misc
assert @[1, 2] is seq
assert ("name", 19) is tuple
var buf: seq[char] = @['a', 'b', 'c']
var p = addr(buf[1])
echo repr(p)

## channels
import std/os

var chan: Channel[string]

proc firstWorker() =
  sleep(1000)
  chan.send("Hello World!")

proc secondWorker() =
  sleep(2000)
  chan.send("Another message")

chan.open()
var worker1: Thread[void]
createThread(worker1, firstWorker)

# block until the message arrives
echo chan.recv()
worker1.joinThread()

var worker2: Thread[void]
createThread(worker2, secondWorker)

# non blocking approach
while true:
  let tried = chan.tryRecv()
  if tried.dataAvailable:
    echo tried.msg
    break

  echo "Pretend I'm doing useful work..."
  sleep(400)

worker2.joinThread()
chan.close()

# passing channels safely
proc worker(channel: ptr Channel[string]) =
  let greeting = channel[].recv()
  echo greeting

proc localChannelExample() =
  var channel = cast[ptr Channel[string]](
    allocShared0(sizeof(Channel[string]))
  )

  channel[].open()
  var thread: Thread[ptr Channel[string]]
  createThread(thread, worker, channel)
  channel[].send("Hello from the main thread!")

  thread.joinThread()
  channel[].close()
  deallocShared(channel)

localChannelExample()

## atomics
import std/atomics

var loc: Atomic[int]
loc.store(4)
assert loc.load == 4
loc.store(2)
assert loc.exchange(7) == 2
assert loc.load == 7

## cpuinfo
import std/cpuinfo
assert countProcessors() == 8
