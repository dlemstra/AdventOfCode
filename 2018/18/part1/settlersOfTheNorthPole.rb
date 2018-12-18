def printGrid(grid)
    puts
    for y in 0..grid.length-1
        for x in 0..grid[0].length-1
            print grid[y][x]
        end
        puts
    end
end

def resourceCount(grid)
    lumberyardCount = 0
    treeCount = 0
    for y in 0..grid.length-1
        for x in 0..grid[0].length-1
            if grid[y][x] == '#'
                lumberyardCount += 1
            elsif grid[y][x] == '|'
                treeCount += 1
            end
        end
    end

    return lumberyardCount * treeCount
end

def getNewValue(grid, x, y)
    case grid[y][x]
    when '.'
        treeCount = 0
        for y1 in [y-1,0].max..[y+1,grid.length-1].min
            for x1 in [x-1,0].max..[x+1,grid[0].length-1].min
                if y1 == y and x1 == x
                    next
                end

                if grid[y1][x1] == '|'
                    treeCount += 1
                    if treeCount == 3
                        break
                    end
                end
            end
            if treeCount == 3
                break
            end
        end

        return treeCount == 3 ? '|' : '.'
    when '|'
        lumberyardCount = 0
        for y1 in [y-1,0].max..[y+1,grid.length-1].min
            for x1 in [x-1,0].max..[x+1,grid[0].length-1].min
                if y1 == y and x1 == x
                    next
                end

                if grid[y1][x1] == '#'
                    lumberyardCount += 1
                    if lumberyardCount == 3
                        break
                    end
                end
            end
            if lumberyardCount == 3
                break
            end
        end

        return lumberyardCount == 3 ? '#' : '|'
    when '#'
        foundLumberyard = false
        foundTree = false
        for y1 in [y-1,0].max..[y+1,grid.length-1].min
            for x1 in [x-1,0].max..[x+1,grid[0].length-1].min
                if y1 == y and x1 == x
                    next
                end

                if grid[y1][x1] == '#'
                    foundLumberyard = true
                elsif grid[y1][x1] == '|'
                    foundTree = true
                end

                if foundLumberyard and foundTree
                    break
                end
            end

            if foundLumberyard and foundTree
                break
            end
        end

        return (foundLumberyard and foundTree) ? '#' : '.'
    end
end

def settlersOfTheNorthPole(input)
    grid = []
    input.each do |line|
        grid.push(line.chomp.split(""))
    end

    printGrid(grid)
    for i in 0..9
        newGrid = []
        for y in 0..grid.length-1
            row = []
            for x in 0..grid[0].length-1
                row.push(getNewValue(grid, x, y))
            end
            newGrid.push(row)
        end

        grid = newGrid

        printGrid(grid)
    end

    return resourceCount(grid)
end