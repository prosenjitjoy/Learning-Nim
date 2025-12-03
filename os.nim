## cmdline
import std/cmdline

echo commandLineParams()
echo paramCount()

## envvars
import std/envvars

echo getEnv("HOME")
assert getEnv("unknownEnv") == ""
assert getEnv("unknownEnv", "doesn't exist") == "doesn't exist"

putEnv("unknownEnv", "I love nim programming language.")
assert getEnv("unknownEnv", "doesn't exist") == "I love nim programming language."
echo getEnv("unknownEnv")

## os
import std/os

let myFile = "/path/to/my/file.nim"
assert splitPath(myFile) == (head: "/path/to/my", tail: "file.nim")

assert expandTilde("~/foo/bar") == getHomeDir() / "foo/bar"
assert expandTilde("~/foo/bar") == joinPath(getHomeDir(), "foo/bar")

assert ".foo".isHidden
assert not ".foo/bar".isHidden
assert not ".".isHidden
assert not "..".isHidden
assert ".foo/".isHidden

assert not isValidFilename(" foo")
assert not isValidFilename("foo ")
assert not isValidFilename("foo.")
assert not isValidFilename("con.txt")
assert not isValidFilename("aux.txt")
assert not isValidFilename("foo/")

## oserrors
import std/oserrors

assert osErrorMsg(OSErrorCode(0)) == ""
assert osErrorMsg(OSErrorCode(1)) == "Operation not permitted"
assert osErrorMsg(OSErrorCode(2)) == "No such file or directory"

## streams
import std/streams

#stringstream
var strm = newStringStream("""The first line
the second line
the third line""")

var line = ""
while strm.readLine(line):
  echo line

#filestream
var strm1 = newFileStream("somefile.txt", fmWrite)

if not isNil(strm1):
  strm1.writeLine("The first line")
  strm1.writeLine("The second line")
  strm1.writeLine("The third line")
  strm1.close()

var strm2 = newFileStream("somefile.txt", fmRead)
var line2 = ""
if not isNil(strm2):
  while strm2.readLine(line2):
    echo line2
  strm1.close()

var strm3 = newStringStream("The first line\nthe second line\nthe third line")
var line3 = ""
assert strm3.atEnd() == false
while strm3.readLine(line3):
  discard
assert strm3.atEnd() == true
strm3.close()

var strm4 = newFileStream("somefile1.txt", fmWrite)
assert "Before write:" & readFile("somefile1.txt") == "Before write:"
strm4.write("hello")
assert "After write:" & readFile("somefile1.txt") == "After write:"
strm4.flush()
assert "After flush:" & readFile("somefile1.txt") == "After flush:hello"
strm4.write("HELLO")
strm4.flush()
assert "After flush:" & readFile("somefile1.txt") == "After flush:helloHELLO"
strm4.close()
assert "After close:" & readFile("somefile1.txt") == "After close:helloHELLO"
sleep(1000)
removeFile("somefile1.txt")
strm4.close()

var strm5 = newStringStream("The first line\nthe second line\nthe third line")
assert strm5.getPosition() == 0
discard strm5.readLine()
assert strm5.getPosition() == 15
strm5.close()

var strm6 = newStringStream("012")
var i: int8
strm6.peek(i)
assert i == 48
var buffer: array[2, char]
strm6.peek(buffer)
assert buffer == ['0', '1']
assert strm6.peekChar() == '0'
strm6.close()

var strm7 = newStringStream("The first line\nthe second line\nthe third line")
strm7.setPosition(4)
assert strm7.readLine() == "first line"
strm7.setPosition(0)
assert strm7.readLine() == "The first line"
strm7.close()

var strm8 = newStringStream("")
strm8.write(1, 2, 3, 4)
strm8.setPosition(0)
assert strm8.readLine() == "1234"
strm8.close()

## terminal
import std/terminal
import std/strutils

for i in 0..100:
  stdout.styledWrite(fgRed, "0% ", fgWhite, '#'.repeat(i), if i >
      50: fgGreen else: fgYellow, "\t", $i, "%")
  stdout.write("\r")
  stdout.flushFile()
  sleep(10)

echo ""
stdout.resetAttributes()

stdout.styledWriteLine({styleBright, styleBlink, styleUnderscore}, "styled text")
stdout.styledWriteLine(fgRed, "red text ")
stdout.styledWriteLine(fgWhite, bgRed, "white text in red background")
stdout.styledWriteLine(" ordinary text without style")
stdout.setBackgroundColor(bgCyan, true)
stdout.setForegroundColor(fgBlue)
stdout.writeLine("blue text in cyan background")
stdout.resetAttributes()
stdout.writeLine(" ordinary text without style")
stdout.styledWriteLine(fgGreen, "green text")

proc error(msg: string) =
  styledWriteLine(stderr, fgRed, "Error: ", resetStyle, msg)

error("this is a error message")

styledEcho styleBright, fgGreen, "[PASS]", resetStyle, fgGreen, " Yay!"
stdout.styledWriteLine(fgRed, "red text ", styleBright, "bold red", fgDefault,
    " bold text", styleDim, " dimmed text ", resetStyle, styleStrikethrough, "not important")
