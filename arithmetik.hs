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

    

