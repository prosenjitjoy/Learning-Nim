## logging
import std/logging

# var logger = newConsoleLogger(fmtStr = "[$datetime] - $levelname: ")
# logger.log(lvlInfo, "a log message")

var consoleLog = newConsoleLogger()
var fileLog = newFileLogger("errors.log", levelThreshold = lvlError)
var rollingLog = newRollingFileLogger("rolling.log")

addHandler(consoleLog)
addHandler(fileLog)
addHandler(rollingLog)

log(lvlError, "an error occurred")
error("an error occurred")
info("something normal happened")
