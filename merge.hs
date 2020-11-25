module Merge where

  merge :: [Integer] -> [Integer] -> [Integer]
  merge [] ys = ys
  merge xs [] = xs
  merge (x:xs) (y:ys)
    | x > y     = y : merge (x:xs) ys
    | otherwise = x : merge xs (y:ys)
  
  odds = 1 : map (+2) odds
  oddPrimes (p : ps) = p : (oddPrimes [p' | p' <- ps, p' `mod` p /= 0])
  primes = 2 : oddPrimes (tail odds)
  
  primepowers :: Integer-> [Integer]
  primepowers n = primeHelper primes n
    where primeHelper (x:xs) n = (merge [x^i | i <- [1..n]] xs) ++ primeHelper xs n
