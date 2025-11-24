import module_a
import module_b except y

# from module_a import `*`

when isMainModule:
  assert (@[1, 2, 3] * @[1, 2, 3]) == @[1, 4, 9]

  write(stdout, module_a.x)
  write(stdout, module_b.x)
  var x: int = 8
  write(stdout, x)

  write(stdout, print(3)) # call module_a.print because of overloading
  write(stdout, print("_")) # call module_b.print because of overloading

  proc print(a: int): string =
    return "\ncalled by main Module: " & $a

  write(stdout, print(2)) # now ambiguous: which `print` to call?
  write(stdout, module_a.print(2))

  # echo y
