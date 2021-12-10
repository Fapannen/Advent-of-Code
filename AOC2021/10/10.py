def classify_syntax(str, finish=False):
	last_opened = []

	mapping = {')':'(', ']':'[', '}':'{', '>':'<'}
	score = {')':3, ']':57, '}':1197, '>':25137}

	for char in str:
		if char == '(':
			last_opened.append(char)

		elif char == ')':
			if last_opened[-1] != mapping[char]:
				return ("corrupted", score[char])
			else:
				last_opened.pop()

		elif char == '[':
			last_opened.append(char)

		elif char == ']':
			if last_opened[-1] != mapping[char]:
				return ("corrupted", score[char])
			else:
				last_opened.pop()

		elif char == '{':
			last_opened.append(char)

		elif char == '}':
			if last_opened[-1] != mapping[char]:
				return ("corrupted", score[char])
			else:
				last_opened.pop()

		elif char == '<':
			last_opened.append(char)

		elif char == '>':
			if last_opened[-1] != mapping[char]:
				return ("corrupted", score[char])
			else:
				last_opened.pop()

	if len(last_opened) != 0:
		if not finish:
			return ("incomplete", 0)
		else:
			final_sc = 0
			sc = {')':1, ']':2, '}':3, '>':4}
			for last in reversed(last_opened):
				if last == '(':
					target = ')'
				if last == '[':
					target = ']'
				if last == '{':
					target = '}'
				if last == '<':
					target = '>'

				final_sc *= 5
				final_sc += sc[target]

			return ("incomplete", final_sc)

	return ("valid", 0)

def main():
	with open("input.txt", "r") as f:
		l = [line.replace("\n", "") for line in f.readlines()]
		score = 0
		for line in l:
			print(classify_syntax(line))
			score += classify_syntax(line)[1]
		print(score)

		p2 = [line for line in l if classify_syntax(line)[0] == "incomplete"]
		ffs = []
		for line in p2:
			print(classify_syntax(line, finish=True))
			ffs.append(classify_syntax(line, finish=True)[1])
		asdw = (sorted(ffs))
		while len(asdw) != 1:
			asdw = asdw[1:-1]
		print(asdw[0])


main()