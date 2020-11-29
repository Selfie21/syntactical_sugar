module Ropes where

    data Rope a = Leaf [a] | Inner (Rope a) Int (Rope a)

    helloRope = Inner (Leaf "Hello") 5 (Inner (Leaf ", w") 3 (Leaf "orld!"))
    numberRope = Inner (Leaf [1,2,3,4]) 4 (Inner (Leaf [1,2]) 2 (Leaf [1,2,3,4,5]))

    ropeLength :: Rope a -> Int
    ropeLength (Leaf a) = length a
    ropeLength (Inner left weight right) = weight + (ropeLength right)
