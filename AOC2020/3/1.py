# Extend array on demand
def extend(array):
    return [elem + elem for elem in array]

with open("input.txt", 'r') as f:
    maze = []
    for line in f.readlines():
        maze.append(line.replace("\n", ""))

    pos = [0, 0]
    treecount = 0
    
    while pos[0] < len(maze) - 1:
        if pos[1] + 3 >= len(maze[0]):
            maze = extend(maze)
            
        if maze[pos[0] + 1][pos[1] + 3] == '#':
            treecount += 1
            
        pos[0] += 1
        pos[1] += 3

    print(treecount)


with open("input.txt", 'r') as f:
    maze = []
    for line in f.readlines():
        maze.append(line.replace("\n", ""))

    directions = [(1,1), (3,1), (5,1), (7,1), (1,2)]
    treecounts = []

    for direction in directions:
        pos = [0,0]
        treecount = 0
        while pos[0] < len(maze) - 1:
            if pos[1] + direction[0] >= len(maze[0]):
                maze = extend(maze)
                
            if maze[pos[0] + direction[1]][pos[1] + direction[0]] == '#':
                treecount += 1
                
            pos[0] += direction[1]
            pos[1] += direction[0]

        treecounts.append(treecount)

    res = 1
    for num in treecounts:
        res = res * num if num != 0 else res
        
    print(res)

    
        
        

    
        
