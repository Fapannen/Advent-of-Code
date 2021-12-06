import Data.List.Split

readInput :: FilePath -> IO [String]
readInput = fmap lines . readFile

removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs) = x : removeDuplicates (filter (\y -> y /= x) xs)

parseEffective :: [Int] -> [(Int, Int)]
parseEffective numbers = removeDuplicates (map (\x -> (x, length (filter (\y -> x == y) numbers))) numbers)

stepEffective :: [(Int, Int)] -> [(Int, Int)]
stepEffective [] = []
stepEffective ((num, occur):xs) = if num == 0 then [(6, occur), (8, occur)] ++ stepEffective xs else (num-1, occur) : stepEffective xs

squash :: [(Int, Int)] -> [(Int, Int)]
squash list = removeDuplicates (map (\(num,occur) -> (num, sum (map snd (filter (\(n,o) -> n == num) list)))) list)

stepEffectiveX :: [(Int, Int)] -> Int -> [(Int, Int)]
stepEffectiveX states 0 = states
stepEffectiveX states num_steps = stepEffectiveX (squash (stepEffective states)) (num_steps - 1)

main :: IO()
main = do
    x <- readInput "input.txt"
    let numbers = map (\x -> read x::Int) (splitOn "," (head x))
    let rev = reverse (parseEffective numbers)
    let result = sum (map snd (stepEffectiveX rev 80)) 
    let result2 = sum (map snd (stepEffectiveX rev 256))
    putStrLn $ show $ result
    putStrLn $ show $ result2