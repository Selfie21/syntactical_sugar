module Arithmetik where

  pow1 b e
    | e < 0 = error "negative exponent"
    | e == 0 = 1
    | otherwise = b * (pow1 b (e-1))



  pow2 b e
    | e < 0 = error "negative exponent"
    | e == 0 = 1
    | (e `mod` 2) == 0 = pow2 (b*b) (e `div` 2)
    | otherwise = b * (pow2 (b*b) (e `div` 2))


  pow3 b e = pow3acc b e 1
    where
      pow3acc b e acc =
        if (e < 0) then error "negative exponent"
        else if(e == 0) then acc
        else if (e `mod` 2) == 0 then pow3acc (b*b) (e `div` 2) acc
        else pow3acc (b*b) (e `div` 2) (b*acc)


  root e r
    | e < 0 = error "negative exponent"
    | r < 0 = error "negative base"
    |otherwise = rootRec 0 (r + 1)
      where
        rootRec low high
          | (high-low) == 1 = low
          | pow3 half e <= r = rootRec half high
          | otherwise = rootRec low half
            where half = (low + high) `div` 2


  isPrime n = isPrimeAcc n 2
    where
      isPrimeAcc n acc
        | (n `mod` acc) == 0 = False
        | acc >= (root 2 n) = True
        | otherwise = isPrimeAcc n (acc+1)
