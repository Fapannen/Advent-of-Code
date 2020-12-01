def main1():
    with open("input.txt", 'r') as f:
        nums = []
        for line in f.readlines():
            nums.append(int(line))

        result = [num1 * num2 for num1 in nums for num2 in nums if num1 + num2 == 2020]
        print(result[0])

def main2():
    with open("input.txt", 'r') as f:
        nums = []
        for line in f.readlines():
            nums.append(int(line))

        result = [num1 * num2 * num3 for num1 in nums for num2 in nums for num3 in nums if num1 + num2 + num3 == 2020]
        print(result[0])


main1()
main2()
