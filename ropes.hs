module Ropes where

  data Rope a = Leaf [a] | Inner (Rope a) Int (Rope a) deriving Show

  ropeLength :: Rope a -> Int
  ropeLength (Leaf a) = length a
  ropeLength (Inner l weight r) = weight + (ropeLength r)

  ropeConcat :: Rope a -> Rope a -> Rope a
  ropeConcat a b = Inner a (ropeLength a) b


  ropeSplitAt :: Int -> Rope a -> (Rope a, Rope a)
  ropeSplitAt index (Leaf a)
    | otherwise = (Leaf (take index a), Leaf (drop index a))

  ropeSplitAt index (Inner l weight r)
    | index < weight = let(edgeleft, middleleft) = ropeSplitAt index l
      in (edgeleft, ropeConcat middleleft r)
    | index > weight = let(middleright, edgeright) = ropeSplitAt (index-weight) r
      in (ropeConcat l middleright, edgeright)


  ropeInsert :: Int -> Rope a -> Rope a -> Rope a
  ropeInsert index a b = let (left, right) = ropeSplitAt index b
    in ropeConcat (ropeConcat left a) right

  
  ropeDelete :: Int -> Int -> Rope a -> Rope a
  ropeDelete i j a = let 
    (ileft, iright) = ropeSplitAt i a
    (jleft, jright) = ropeSplitAt j a
    in ropeConcat ileft jright
