## monotimes
import std/monotimes

let a = getMonoTime()
let b = getMonoTime()
echo a
echo b
assert a <= b

## times
import std/times
import std/os

let time = cpuTime()
sleep(100)
echo "Time taken: ", cpuTime() - time

let now1 = now()
let now2 = now().utc
let now3 = getTime()
echo now1
echo now2
echo now3

echo "One hour from now: ", now() + initDuration(hours = 1)
echo "One year from now: ", now() + 1.years
echo "One month from now: ", now() + 1.months
echo "One month from now: ", now() + months(1)

let dt = parse("2000-01-01", "yyyy-MM-dd")
echo dt.format("yyyy-MM-dd")
echo now1.getIsoWeekAndYear().isoweek

var dt1 = dateTime(1970, mJan, 01, 00, 00, 00, 00, utc())
var tm = dt1.toTime()
echo tm
assert times.format(tm, "yyyy-MM-dd'T'HH:mm:ss", utc()) == "1970-01-01T00:00:00"

assert getDayOfWeek(7, mFeb, 1997) == dFri
assert $getDayOfWeek(7, mFeb, 1997) == "Friday"

assert getDayOfYear(10, mFeb, 2000) == 40
assert getDaysInMonth(mFeb, 2000) == 29
assert getDaysInYear(2000) == 366
assert isLeapYear(2000)
assert not isLeapYear(1900)
