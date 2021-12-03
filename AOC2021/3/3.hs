import Data.List
import Data.Char

readInput :: FilePath -> IO [String]
readInput = fmap lines . readFile

getMajorBit :: String -> Int
getMajorBit "" = -1
getMajorBit str = if sum (map (\x -> if x == '1' then 1 else 0) str) >= sum (map (\x -> if x == '0' then 1 else 0) str) then 1 else 0  

getMinorBit :: String -> Int
getMinorBit x = 1 - getMajorBit x

listToDec :: [Int] -> Int
listToDec [] = 1
listToDec bin = foldl (\y x -> y + fst x * (2 ^ snd x)) 0 (zip (reverse bin) [0..(length bin)])

-- PART TWO

ogr :: [String] -> String -> Int -> [String]
ogr binaries "major" pos = let f = filter (\x -> digitToInt (x !! pos) == (map getMajorBit (transpose binaries)) !! pos) binaries in
                               if length f == 1 then f else ogr f "major" (pos + 1)
ogr binaries "minor" pos = let f = filter (\x -> digitToInt (x !! pos) == (map getMinorBit (transpose binaries)) !! pos) binaries in
                               if length f == 1 then f else ogr f "minor" (pos + 1)

main :: IO()
main = do
    x <- readInput "input.txt"
    let y = transpose x
    let mapped_majors = map getMajorBit y
    let mapped_minors = map getMinorBit y
    let oxygenGeneratorRating = ogr x "major" 0
    let co2ScrubberRating = ogr x "minor" 0

    putStrLn $ show $ mapped_majors
    putStrLn $ show $ mapped_minors
    putStrLn $ show $ (listToDec mapped_majors) * (listToDec mapped_minors)
    putStrLn "Part Two"
    putStrLn $ show $ oxygenGeneratorRating
    putStrLn $ show $ co2ScrubberRating
    putStrLn $ show $ listToDec (map (\ogrbin -> digitToInt ogrbin) (head oxygenGeneratorRating)) * listToDec (map (\co2bin -> digitToInt co2bin) (head co2ScrubberRating))


