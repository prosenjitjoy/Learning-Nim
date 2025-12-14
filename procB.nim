import std/os
import std/strformat

echo "Hello from Program B"
echo "Program B starting work..."
for i in 1..3:
  echo &" Iteration {i}"
  sleep(500)
echo "Program B finished"
