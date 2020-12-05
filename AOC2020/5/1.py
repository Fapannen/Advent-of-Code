def bsearch(power, string, upper, lower):
    res = 0
    for i in range(power):
        if string[i] == upper:
            res += 2 ** ((power-1)-i)
    return res

with open("input.txt", 'r') as f:
    idxs = []
    maxidx = 0
    for l in f.readlines():
        line = l.replace("\n", "")
        row = bsearch(7, line, 'B', 'F')
        col = bsearch(3, line[-3:], 'R', 'L')

        ID = (row * 8) + col

        if ID > maxidx:
            maxidx = ID

        idxs.append(ID)

    idxs = sorted(idxs)
    res = [idx for idx in idxs if idx-1 not in idxs or idx+1 not in idxs]
    
    print(res) # the missing one is the one that has both neighbors in here
               # in my case res = [85, 650, 652, 890] so the seat ID is 651
        
