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
