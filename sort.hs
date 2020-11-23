module Sort where

  insert x [] = [x]
  insert x (y : ys)
    | x <= y  = x : y : ys
    |otherwise  = y : insert x ys

  insertSort [] = []
  insertSort (x : xs) = insert x (insertSort xs)

  merge [] y = y
  merge (x:xs) (y:ys) = merge xs (insert x (y:ys))


  mergeSort []  = []
  mergeSort [x] = [x]
  mergeSort xs  = merge
    (mergeSort (take((length xs) ‘div‘ 2) xs))
    (mergeSort (drop((length xs) ‘div‘ 2) xs))
