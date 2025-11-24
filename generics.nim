type
  BinaryTree*[T] = ref object
    left: BinaryTree[T]
    right: BinaryTree[T]
    data: T

proc newNode*[T](data: T): BinaryTree[T] =
  #constructor for a node
  return BinaryTree[T](data: data)

proc add*[T](root: var BinaryTree[T], n: BinaryTree[T]) =
  #insert a node into the tree
  if root == nil:
    root = n
  else:
    var it = root
    while it != nil:
      var c = cmp(it.data, n.data)
      if c < 0:
        if it.left == nil:
          it.left = n
          return
        it = it.left
      else:
        if it.right == nil:
          it.right = n
          return
        it = it.right

proc add*[T](root: var BinaryTree[T], data: T) =
  # convenience proc
  add(root, newNode(data))

iterator preorder*[T](root: BinaryTree[T]): T =
  var stack: seq[BinaryTree[T]] = @[root]
  while stack.len > 0:
    var n = stack.pop()
    while n != nil:
      yield n.data
      add(stack, n.right)
      n = n.left

var root: BinaryTree[string]
add(root, newNode("hello")) # instantiates `newNode` and `add`
add(root, "world") # instantiates the second `add` proc

for str in preorder(root):
  stdout.writeLine(str)
