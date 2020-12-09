module ChurchNumbers where

  type Church t = (t -> t) -> t -> t -- church numbers

  zero = \s z-> z
  one  = \s z-> s z

  church2int :: Church Integer -> Integer
  church2int num = num (1+) 0

  int2church :: Integer -> Church t
  int2church 0 = \s z -> z
  int2church num = (\n s z -> s (n s z)) (int2church (num-1))
