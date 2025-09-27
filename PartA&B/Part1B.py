#Coursework 1 - Corey Yule, Euan Grierson 
#Part 1A
import math
import numpy as np
class SudokuCSP:
    def __init__(self, grid, domains):
        #Defines a grid of 81 squares (NOTE: this is currently fully empty as 0 defines as an empty square)
        self.grid = grid.flatten()
        self.domains = {}
        #Loop over each square in the grid this sorts the domain of hidden numbers
        for r in range(9):
            for c in range(9):
                if self.grid[r][c] == 0:
                    self.domains[(r,c)] = set(range(1,10)) #1-9
                else:
                    self.domains[(r,c)] =  {self.grid[r][c]}

    def get_puzzle(file):
        with open(file) as f:
            text = f.read()
    
        # replace commas with spaces so it works with numpy
        text = text.replace(",", " ")
        

        # now it loads into numpy to read it into an array
        from io import StringIO
        grid = np.loadtxt(StringIO(text), dtype=int)

        return grid


    #Checks constraints -> 3x3 no dups, rows no dupes, no dupes
    def rule_check(self, row, col, val, grid):
        #Check Row
        for r in range(9):
            if r!= row and grid[r][col] == val:
                return False
        #Check Column
        for c in range(9):
            if c!= col and grid[row][c] == val:
                return False
        #Check 3x3
        box_row = (row // 3)*3
        box_col = (col // 3)*3

        return True


# #Visual thing for my brain to work.
# grid= [0,1,0,1,0,1,0,1,0]
# for i in range(9):
#         print(grid)
    grid = get_puzzle("test.txt")
    print(grid)