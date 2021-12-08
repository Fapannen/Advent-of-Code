import Data.List
import Data.List.Split

readInput :: FilePath -> IO [String]
readInput = fmap lines . readFile

parseEntries :: [[String]] -> [([String], [String])]
parseEntries [] = []
parseEntries (x:xs) = (filter (\as -> as /= "") (splitOn " " (head x)),filter (\bs -> bs /= "") (splitOn " " (last x))) : parseEntries xs

idk :: ([String], [String]) -> Int -> Int
idk (_, outDigs) num = num + length (filter (\x -> let len = length x in len == 2 || len == 3 || len == 4 || len == 7) outDigs)

main :: IO()
main = do
    x <- readInput "input.txt"
    let entries = map (splitOn "|") x
    let parsedEntries = parseEntries entries
    let result1 = foldr idk 0 parsedEntries
    putStrLn $ show $ result1