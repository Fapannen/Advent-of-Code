readInput :: FilePath -> IO [String]
readInput = fmap lines . readFile

convertToInt :: [String] -> [Int]
convertToInt [] = []
convertToInt (x:xs) = (read x :: Int):convertToInt xs 


mapToTrend :: [Int] -> [String]
mapToTrend [] = []
mapToTrend (x:[]) = []
mapToTrend (first:rest) = if (head rest) - first  > 0 then "Increase":mapToTrend rest else "Decrease":mapToTrend rest

countIncreases :: [String] -> Int
countIncreases x = length (filter (\x -> x == "Increase") x)

-- PART 2

mapToThreeWindows :: [Int] -> [Int]
mapToThreeWindows [] = []
mapToThreeWindows (x:[]) = []
mapToThreeWindows (x:y:[]) = []
mapToThreeWindows (x:y:z) = (x + y + (head z)) : mapToThreeWindows (y:z)

{-

--PART 1

x <- readInput "input.txt"
countIncreases (mapToTrend (convertToInt x))

Better would be to edit function mapToTrend to do all the work

mapToTrend :: [Int] -> Int
mapToTrend [] = 0
mapToTrend (x:[]) = 0
mapToTrend (first:rest) = if (head rest) - first > 0 then 1 + mapToTrend rest else 0 + mapToTrend rest

-- PART 2

x <- readInput "input.txt"
countIncreases (mapToTrend (mapToThreeWindows (convertToInt x)))

-}
