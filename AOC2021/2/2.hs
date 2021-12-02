import Data.List.Split

readInput :: FilePath -> IO [String]
readInput = fmap lines . readFile

mapToTuples :: [String] -> [[String]]
mapToTuples [] = []
mapToTuples x = map (splitOn " ") x 

calculateForward :: [[String]] -> Int
calculateForward [] = 0
calculateForward (x:xs) = if head x == "forward" then (read (head (tail x)) :: Int) + calculateForward xs else 0 + calculateForward xs

getDepth :: Int -> [String] -> Int
getDepth depth info = if head info == "up" then depth - (read (head (tail info)) :: Int) else if head info == "down" then depth + (read (head (tail info)) :: Int) else depth

calculateDepth :: [[String]] -> Int
calculateDepth [] = 0
calculateDepth x = foldl getDepth 0 x 

-- Part TWO

wtfIsThis :: Int -> Int -> Int -> [[String]] -> (Int, Int)
wtfIsThis aim depth forward [] = (forward, depth)
wtfIsThis aim depth forward (x:xs) = if head x == "up" then wtfIsThis (aim - (read (head (tail x)) :: Int)) depth forward xs else if head x == "down" then wtfIsThis (aim + (read (head (tail x)) :: Int)) depth forward xs else wtfIsThis aim (depth + (aim * (read(head(tail x)) :: Int))) (forward + (read(head(tail x)) :: Int)) xs


main :: IO()
main = do
    x <- readInput "input.txt"
    let y = mapToTuples x
    putStrLn $ show $ wtfIsThis 0 0 0 y
