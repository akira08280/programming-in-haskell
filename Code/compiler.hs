-- Compiler example from chapter 16 of Programming in Haskell,
-- Graham Hutton, Cambridge University Press, 2016.

data Expr = Val Int | Add Expr Expr

eval :: Expr -> Int
eval (Val n)   = n
eval (Add x y) = eval x + eval y

type Stack = [Int]

type Code = [Op]

data Op = PUSH Int | ADD
          deriving Show

exec :: Code -> Stack -> Stack
exec []           s           = s
exec (PUSH n : c) s           = exec c (n : s)
exec (ADD : c)    (m : n : s) = exec c (n+m : s)

comp' :: Expr -> Code -> Code
comp' (Val n)   c = PUSH n : c
comp' (Add x y) c = comp' x (comp' y (ADD : c))

comp :: Expr -> Code
comp e = comp' e []
