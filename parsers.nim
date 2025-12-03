## parsecfg
import std/parsecfg
import std/strutils
import std/streams

let configFile = "example.ini"
var f = newFileStream(configFile, fmRead)
assert f != nil

var p: CfgParser
p.open(f, configFile)
while true:
  var e = next(p)
  case e.kind
  of cfgEof:
    break
  of cfgSectionStart:
    echo "new section: " & e.section
  of cfgKeyValuePair:
    echo "key-value-pair: " & e.key & ": " & e.value
  of cfgOption:
    echo "command: " & e.key & ": " & e.value
  of cfgError:
    echo e.msg

close(p)

var dict = newConfig()
dict.setSectionKey("", "charset", "utf-8")
dict.setSectionKey("Package", "name", "hello")
dict.setSectionKey("Package", "--threads", "on")
dict.setSectionKey("Author", "name", "nim-lang")
dict.setSectionKey("Author", "website", "nim-lang.org")
assert $dict == """
charset=utf-8
[Package]
name=hello
--threads:on
[Author]
name=nim-lang
website=nim-lang.org
"""

var cfg = loadConfig("config.ini")
let charset = cfg.getSectionValue("", "charset")
let threads = cfg.getSectionValue("Package", "--threads")
let pname = cfg.getSectionValue("Package", "name")
let name = cfg.getSectionValue("Author", "name")
let website = cfg.getSectionValue("Author", "website")
echo pname
echo name
echo website
cfg.delSectionKey("Author", "website")
cfg.writeConfig("config1.ini")

## parsecsv
import std/parsecsv
import std/os

let content = """One,Two,Three,Four
1,2,3,4
10,20,30,40
100,200,300,400
"""
writeFile("temp.csv", content)

var p1: CsvParser
p1.open("temp.csv")
p1.readHeaderRow()
while p1.readRow():
  echo "new row: "
  for col in items(p1.headers):
    echo "##", col, ":", p1.rowEntry(col), "##"

p1.close()
