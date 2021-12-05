import Data.List.Split
import Data.List

type Point = (Int, Int)
type Line = (Point, Point)


readInput :: FilePath -> IO [String]
readInput = fmap lines . readFile

constructLines :: [[String]] -> String -> [Line]
constructLines [] _ = []
constructLines (x:xs) part = let begin = splitOn "," (head x) in
                           let end   = splitOn "," (last x) in
                           let x1 = read (head begin) :: Int in
                           let y1 = read (last begin) :: Int in
                           let x2 = read (head end) :: Int in
                           let y2 =  read (last end) :: Int in
                           if part == "firstPart" then
                           if x1 == x2 || y1 == y2 then ((x1, y1), (x2,y2)) : constructLines xs "firstPart" else constructLines xs "firstPart"
                           else ((x1,y1), (x2,y2)) : constructLines xs "secondPart"

domain :: Int -> Int -> [Int]
domain x1 x2 = if x1 < x2 then [x1..x2] else [x2..x1]

domainDiag :: Int -> Int -> [Int]
domainDiag x1 x2 = if x1 < x2 then [x1..x2] else reverse [x2..x1]

generateMayhem :: [Line] -> [Point]
generateMayhem [] = []
generateMayhem (((x1, y1), (x2, y2)) : xs) = if (x1 /= x2 && y1 /= y2) then
                                             zip (domainDiag x1 x2) (domainDiag y1 y2) ++ generateMayhem xs
                                             else if x1 /= x2 then
                                             zip (domain x1 x2) (repeat y1) ++ generateMayhem xs
                                             else
                                             zip (repeat x1) (domain y1 y2) ++ generateMayhem xs

removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs) = x : removeDuplicates (filter (\y -> y /= x) xs)

solveTask1 :: [Point] -> Int
solveTask1 pts = let multiple_occupied = map (\x -> (x, length (filter (\y -> y == x) pts))) pts in
                 length (removeDuplicates multiple_occupied)               

main :: IO()
main = do
    x <- readInput "input.txt"
    putStrLn $ show $ 42

    {- PART ONE
    let y = map (splitOn " -> ") x
    let lines = constructLines y "firstPart"
    let mayhem = generateMayhem lines
    let zeby = filter (\x -> length (filter (\y -> y == x) mayhem) > 1) mayhem
    let result = length (removeDuplicates zeby)
    putStrLn "Now wait :)))))"
    putStrLn $ show $ result
    -}

    {- PART TWO
    let y = map (splitOn " -> ") x
    let lines = constructLines y "secondPart"
    let mayhem = generateMayhem lines
    let zeby = filter (\x -> length (filter (\y -> y == x) mayhem) > 1) mayhem
    let result = length (removeDuplicates zeby)
    putStrLn $ show $ result
    -}