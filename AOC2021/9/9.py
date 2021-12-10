
def calc_lows(board):
	accum = 0
	for row in range(len(board)):
		for col in range(len(board[0])):
			curr = board[row][col]

			up = board[row-1][col] if row - 1 >= 0 else 10
			left = board[row][col-1] if col - 1 >= 0 else 10
			right = board[row][col+1] if col + 1 <= len(board[0]) - 1 else 10
			bot = board[row+1][col] if row + 1 <= len(board) - 1 else 10

			neighborhood = [up, left, right, bot]

			accum += 1 + curr if curr < min(neighborhood) else 0
	return accum

def find_pos(pos, basins):
	for b in range(len(basins)):
		if (pos[0], pos[1]) in basins[b]:
			return b

	return -1

def merge_basins(basins, a, b):
	b1 = basins[a]
	b2 = basins[b]
	newbasins = [basins[i] for i in range(len(basins)) if (i != a and i != b)]
	newbasins.append(b1 + b2)
	return newbasins

def calc_basins(board):
	pos = []
	for row in range(len(board)):
		for col in range(len(board[0])):
			if board[row][col] != 9:
				pos.append((row, col))

	basins = []

	for (x,y) in pos:
		exist_left = find_pos((x, y - 1), basins)
		exist_right = find_pos((x, y + 1), basins)
		exist_up = find_pos((x-1, y), basins)
		exist_down = find_pos((x+1, y), basins)

		# No point in neighborhood is part of a basin
		if exist_down == -1 and exist_up == -1 and exist_left == -1 and exist_right == -1:
			basins.append([(x,y)])
			continue
		qwe = [exist_right, exist_left, exist_up, exist_down]

		# If there are two different basins joining together, we need to unify them
		if exist_left != -1 and exist_up != -1 and exist_left != exist_up:
			basins = merge_basins(basins, exist_left, exist_up)
			basins[-1].append((x,y))
		else:
			idx = max(qwe)
			basins[idx].append((x,y))

	lens = [len(basin) for basin in basins]
	ls = sorted(lens)
	
	return ls[-1] * ls[-2] * ls[-3]


def main():
	with open("input.txt", "r") as f:
		l = [line.replace("\n", "") for line in f.readlines()]
		
		board = []
		for seq in l:
			s = []
			for num in seq:
				s.append(int(num))
			board.append(s)

		print(calc_lows(board))
		print(calc_basins(board))




main()