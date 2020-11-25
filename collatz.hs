module Collatz where

  collatz :: Int-> [Int]
  collatz a
    | a <= 0    = error "undefined for non-positive"
    | otherwise = iterate collatzHelper a
      where
        collatzHelper t
          | (t `mod` 2) == 0 = t `div` 2
          | otherwise = (3*t + 1)

  num :: Int -> Int
  num n = numAcc (collatz n) 0 
    where
      numAcc (1:xs) acc = acc
      numAcc (x:xs) acc = numAcc xs (acc+1)

  -- ohne herausfinden welches m es ist war das echt schön aber so hab ich es nicht besser hinbekommen ...
  maxNum :: Int -> Int -> (Int, Int)
  maxNum a b = maxNumAcc (map num [a..b]) 0 0 0
    where 
      maxNumAcc [] acc current counter = (current, acc)
      maxNumAcc (x:xs) acc current counter
        | (max x acc) == x = maxNumAcc xs (max x acc) (counter+a) (counter+1)
        | otherwise        = maxNumAcc xs (max x acc) current (counter+1)
