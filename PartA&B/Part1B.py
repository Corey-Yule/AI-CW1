#Coursework 1 - Corey Yule, Euan Grierson 
#Part 1A
import math
class SudokuCSP:
    def __init__(self, grid, domains):
        #Defines a grid of 81 squares (NOTE: this is currently fully empty as 0 defines as an empty square)
        self.grid = grid
        self.domains = {}
        #Loop over each square in the grid
        for i in range(81):
            if self.grid[i] == 0:
                self.domains[i] = set(range(1,10)) #1-9
            else:
                self.domains[i] =  {self.grid[i]}

    #Checks constraints -> 3x3 no dups, rows no dupes, no dupes
    def rule_check(self, cell, val, assignment):
        #find the row:
        row = math.floor(cell / 9)
        #find column
        col = cell % 9
        #find the box 3x3
        box_row = math.floor(row /3) *3
        box_col = math.floor(col /3) *3

        #Idk the rest of the maths behind this basically in theory loop round everything and check if the index of whatever you are on conflicts with neighbors?




#Visual thing for my brain to work.
grid= [0,1,0,1,0,1,0,1,0]
for i in range(9):
        print(grid)