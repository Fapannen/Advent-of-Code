import Data.List
import Data.List.Split

readInput :: FilePath -> IO [String]
readInput = fmap lines . readFile

getDistance :: String -> [Int] -> [Int] -> [Int]
getDistance _ real_positions [] = []
getDistance "humanEngineering" real_positions (x:xs) = sum (map (\y -> abs (x - y)) real_positions) : getDistance "humanEngineering" real_positions xs
getDistance "crabEngineering"  real_positions (x:xs) = sum (map (\y -> sum (take (abs (x - y)) (iterate (+1) 1))) real_positions) : getDistance "crabEngineering" real_positions xs

getIdealPosition :: String -> [Int] -> Int
getIdealPosition "humanEngineering" positions =  let max = maximum positions
                                                     min = minimum positions in
                                                     minimum (getDistance "humanEngineering" positions [min..max])
getIdealPosition "crabEngineering"  positions  = let max = maximum positions
                                                     min = minimum positions in
                                                     minimum (getDistance "crabEngineering"  positions [min..max])

main :: IO()
main = do
    x <- readInput "input.txt"
    let numbers = map (\x -> read x::Int) (splitOn "," (head x))
    let result = getIdealPosition "humanEngineering" numbers
    let result2 = getIdealPosition "crabEngineering" numbers
    putStrLn $ show $ result
    putStrLn $ show $ result2