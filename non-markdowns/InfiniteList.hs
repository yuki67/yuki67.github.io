module InfiniteList where

-- | ones is a infinite list which all content is 1.
-- >>> take 5 ones
-- [1,1,1,1,1]
ones :: Num a => [a]
ones = 1:ones

-- Functions on sequence.
add :: Num a => [a] -> [a] -> [a]
add = zipWith (+)
addConst :: Num a => [a] -> a -> [a]
addConst s x = map (+ x) s

-- | The first element of twoPowered is 1, and the tail is sum of two twoPowereds,
-- | i.e. a element of twoPowered is double of the previous element.
-- >>> take 10 twoPowered
-- [1,2,4,8,16,32,64,128,256,512]
twoPowered :: Num a => [a]
twoPowered = 1:zipWith (+) twoPowered twoPowered

-- | Fibonacci sequence defined without if.
-- >>> take 10 fib
-- [1,1,2,3,5,8,13,21,34,55]
fib :: Num a => [a]
fib = 1:1:add fib (tail fib)

-- | Some more examples...
-- >>> take 10 integer
-- [1,2,3,4,5,6,7,8,9,10]
integer :: Num a => [a]
integer = 1 : addConst integer 1
-- | >>> take 10 $ expand 1 7 10
-- [1,4,2,8,5,7,1,4,2,8]
-- >>> take 10 $ expand 1 3 2
-- [0,1,0,1,0,1,0,1,0,1]
expand :: Integer -> Integer -> Integer -> [Integer]
expand num den digit = num * digit `div` den : expand ((num*digit) `mod` den) den digit

-- | Cumulative Sum
-- >>> take 10 $ cumulate integer
-- [1,3,6,10,15,21,28,36,45,55]
-- >>> take 10 $ cumulate fib
-- [1,2,4,7,12,20,33,54,88,143]
cumulate :: Num a => [a] -> [a]
cumulate s = head s : addConst (cumulate (tail s)) (head s)

-- | fromCoeff creates a function whose coeffcients of geometric series expansion is "coeff".
-- >>> take 10 $ powerSeries 10
-- [1,10,100,1000,10000,100000,1000000,10000000,100000000,1000000000]
-- >>> fromCoeff (powerSeries 10) 1
-- 1111111111111111111111111111111
powerSeries :: Num a => a -> [a]
powerSeries x = 1 : map (* x) (powerSeries x)
fromCoeff :: Num a => [a] -> a -> a
fromCoeff coeff x = cumulate (zipWith (*) coeff (powerSeries x)) !! 30

-- | Calculate e^x using its definition.
-- >>> take 10 fact
-- [1,1,2,6,24,120,720,5040,40320,362880]
-- >>> exp' 1
-- 2.718281828459045
-- >>> exp' 2
-- 7.38905609893065
-- >>> (exp' 10) ** 0.1 - exp' 1
-- -2.1702204477946907e-8
fact :: Num a => [a]
fact = 1 : zipWith (*) fact integer
exp' :: Fractional a => a -> a
exp' = fromCoeff (map (\n -> 1/n) fact)
