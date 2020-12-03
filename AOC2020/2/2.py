with open("input.txt", "r") as f:
    count = 0
    for line in f.readlines():
        split = line.split(" ")

        letter_range = split[0].split("-")
        letter = split[1].split(":")[0]
        password = split[2]

        parse = [let for let in password if let == letter]
        if len(parse) >= int(letter_range[0]) and len(parse) <= int(letter_range[1]):
            count += 1
            
    print(count)

# Second part
with open("input.txt", "r") as f:
    count = 0
    for line in f.readlines():
        split = line.split(" ")

        letter_range = split[0].split("-")
        letter = split[1].split(":")[0]
        password = split[2]

        fp = int(letter_range[0])
        sp = int(letter_range[1])

        if password[fp - 1] != password[sp - 1] and (password[fp - 1] == letter or password[sp - 1] == letter):
            count += 1
            
    print(count)
