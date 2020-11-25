module Polynom where

  type Polynom = [Double]
  
  cmult :: Polynom -> Double -> Polynom
  cmult p k = map (k*) p

  eval :: Polynom -> Double -> Double
  eval p x = foldr oneStepEval 0 p
    where oneStepEval y ys = y + x*(ys)

  -- /w Combinator
  deriv :: Polynom -> Polynom
  counterlist = 1 : map (+1) counterlist
  deriv (x:xs) = zipWith (*) counterlist xs
  