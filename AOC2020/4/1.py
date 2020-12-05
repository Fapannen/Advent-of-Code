with open("input.txt", 'r') as f:
    txt = f.read()
    passports = txt.split("\n\n")
    fix = [psp.replace("\n", " ") for psp in passports]

    fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    count = 0
    for passport in fix:
        found = True
        for field in fields:
            if field not in passport:
                found = False
                break
        if found:
            count += 1

    print(count)


with open("input.txt", 'r') as f:
    txt = f.read()
    passports = txt.split("\n\n")
    fix = [psp.replace("\n", " ") for psp in passports]

    fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    count = 0
    for passport in fix:
        foundf = True
        for field in fields:
            if field not in passport:
                foundf = False
                break
        if not foundf:
            continue
            
        parse = passport.split(" ")
        found = True
        
        for entry in parse:
            spl = entry.split(":")
            if len(spl) == 1:
                continue

            attribute = spl[0]
            value = spl[1]

            if attribute == "byr":
                if int(value) < 1920 or int(value) > 2002:
                    found = False
                    break
                
            elif attribute == "iyr":
                if int(value) < 2010 or int(value) > 2020:
                    found = False
                    break

            elif attribute == "eyr":
                if int(value) < 2020 or int(value) > 2030:
                    found = False
                    break

            elif attribute == "hgt":
                if value[-2:] == "cm":
                    val = int(value[:-2])
                    if val < 150 or val > 193:
                        found = False
                        break
                    
                elif value[-2:] == "in":
                    val = int(value[:-2])
                    if val < 59 or val > 76:
                        found = False
                        break
                else:
                    found = False
                    break
                    
            elif attribute == "hcl":
                if len(value) == 7 and value[0] == "#":
                    for i in range(6):
                        if not value[i+1].isalnum():
                            found = False
                            break
                else:
                    found = False
                    break
                
            elif attribute == "ecl":
                if value not in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
                    found = False
                    break

            elif attribute == "pid":
                if len(value) != 9:
                    found = False
                    break
            if found:
                print(attribute, " : ", value)
                
        if found:
            count += 1

    print(count)
