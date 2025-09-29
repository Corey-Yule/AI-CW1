#Coursework 1 - Corey Yule, Euan Grierson 
#Part 1A
import math
import csv
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
        #open file in read mode
        datafile = open(file, 'r')
        #read the file with a comma delimiter
        reader=csv.reader(datafile, delimiter=',')
        #define the grid as an empty array
        grid=[]
        #for each row in the file, append to the grid
        for row in reader:
            grid.append(row)
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

        for r in(box_row, box_row + 3):
            for c in(box_col, box_col + 3):
                if(r != row or c != col) and grid[r][c] == val:
                    return False
                
        return True


# #Visual thing for my brain to work.
grid = SudokuCSP.get_puzzle("test.csv")
print(SudokuCSP.rule_check(0, 1, 5, grid))