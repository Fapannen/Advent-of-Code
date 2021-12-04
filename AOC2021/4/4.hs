import Data.List.Split
import Data.List

type BingoBoard = [[(Int, Bool)]]
type Bingo = [BingoBoard]

readInput :: FilePath -> IO [String]
readInput = fmap lines . readFile

constructBingoBoard :: [String] -> BingoBoard
constructBingoBoard [] = []
constructBingoBoard (x:xs) = zip (map (\x -> read x::Int) (filter (\x -> x /= "") ((splitOn " ") x))) (repeat False) : constructBingoBoard xs

constructBingo :: [String] -> Bingo
constructBingo [] = []
constructBingo boards = if length (dropWhile (/= "") boards) /= 0 then constructBingoBoard (takeWhile (/= "") boards) : constructBingo (tail (dropWhile (/= "") boards)) else [constructBingoBoard (takeWhile (/= "") boards)]

cleanBingo :: Bingo -> Bingo
cleanBingo bingo = map (\board -> filter (\row -> length row > 0) board) bingo

drawNumberInBoard :: BingoBoard -> Int -> BingoBoard
drawNumberInBoard board draw = map (\row -> map (\(number, bool) -> if number == draw then (number, True) else (number,bool)) row) board 

drawNumber :: Bingo -> Int -> Bingo
drawNumber bingo draw = map (\x -> drawNumberInBoard x draw) bingo

checkRowWin :: [(Int, Bool)] -> Bool
checkRowWin [] = False
checkRowWin row = and (map (\x -> snd x) row)

checkAnyRowWin :: BingoBoard -> Bool
checkAnyRowWin board = or (map checkRowWin board)

checkBoardWin :: BingoBoard -> Bool
checkBoardWin board = checkAnyRowWin board || checkAnyRowWin (transpose board)

checkWin :: Bingo -> Bool
checkWin bingo = or (map checkBoardWin bingo)

getWinningScore :: Bingo -> Int
getWinningScore bingo = sum (map (\row -> sum (map (\(num, bool) -> if bool then 0 else num) row)) (head (filter (\x -> checkBoardWin x) bingo)))

playBingo :: Bingo -> [Int] -> Int
playBingo bingo draw = let aftermath = drawNumber bingo (head draw) in
                           if checkWin aftermath then (getWinningScore aftermath) * (head draw)  else playBingo aftermath (tail draw)

playBingop2 :: Bingo -> [Int] -> Int
playBingop2 bingo draw = let aftermath = filter (\x -> not (checkBoardWin x)) (drawNumber bingo (head draw)) in
                             if length aftermath == 1 then playBingo aftermath (tail draw) else playBingop2 aftermath (tail draw)

main :: IO()
main = do
    input <- readInput "input.txt"
    let d = head input
    let bingo = cleanBingo (constructBingo (tail (tail input))) -- First element of "boards" is empty string, start with the next one
    let result = playBingo bingo (map (\x -> read x::Int) (splitOn "," d))
    let result2 = playBingop2 bingo (map (\x -> read x::Int) (splitOn "," d))
    putStrLn $ show $ result
    putStrLn $ show $ result2
