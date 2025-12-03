## unittest
import std/unittest

suite "a proper description goes here":
  echo "suite setup: run once before the tests"

  setup:
    echo "run before each test"

  teardown:
    echo "run after each test"

  test "essential truths":
    require(true)

  test "slightly less obvious":
    check("asd"[2] == 'd')

  test "out of bounds error is thrown on bad access":
    let v = @[1, 2, 3]
    expect(IndexDefect):
      discard v[4]

  echo "suite teardown: run once after the tests"
