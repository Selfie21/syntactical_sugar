module Tree where
  
  data Tree t =  Leaf | Node (Tree t) t (Tree t)
  someTree = Node (Node Leaf 1 Leaf) 3 Leaf

  size Leaf = 0
  size (Node left x right) = 1 + (size left) + (size right)

  height Leaf = 0
  height (Node left x right) = 1 + max (height left) (height right)

  mapT f Leaf = Leaf
  mapT f (Node left x right) = Node (mapT f left) (f x) (mapT f right)
