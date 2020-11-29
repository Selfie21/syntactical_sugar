module Ast where

  type Env t = t -> Integer

  testenv :: Env [Char]
  testenv a = 1

  -- t type parameter
  data Exp t =
    Var t | Const Integer | Sum (Exp t) (Exp t) |
    Less (Exp t) (Exp t) | And (Exp t) (Exp t) | Not (Exp t) |
    IfThen (Exp t) (Exp t) (Exp t)


  eval :: Env t -> Exp t -> Integer
  eval envir (Const c) = c
  eval envir (Var x) = envir x
  eval envir (Sum a b) = (eval envir a) + (eval envir b)

  eval envir (Less a b)
    | (eval envir a) < (eval envir b) = 1
    | otherwise = 0
  eval envir (And a b)
    | ((eval envir a) > 0) && ((eval envir b) > 0) = 1
    | otherwise = 0
  eval envir (Not a)
    | (eval envir a) > 0 = 0
    | otherwise = 1
  eval envir (IfThen a b c)
    | (eval envir a) > 0 = (eval envir c)
    | otherwise = (eval envir b)

  instance (Show t) => Show (Exp t) where
    show (Const c)      = show c
    show (Var x)        = show x
    show (Sum a b)      = "(" ++ show a ++ " + " ++ show b ++ ")"
    show (Less a b)     = "(" ++ show a ++ " < " ++ show b ++ ")"
    show (And a b)      = "(" ++ show a ++ " & " ++ show b ++ ")"
    show (Not a)        = "(!" ++ show a ++ ")"
    show (IfThen a b c) = "(If " ++ show a ++ " Then " ++ show b ++
                          " Else " ++ show c ++ ")"
