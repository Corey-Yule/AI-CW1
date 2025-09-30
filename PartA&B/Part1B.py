#Coursework 1 - Corey Yule, Euan Grierson 
#Part 1A

#Imports
import csv
import numpy as np
import tkinter as tk
#SudokuClass
class SudokuCSP:
    def __init__(self, grid, domains):
        #Defines a grid of 81 squares (NOTE: this is currently fully empty as 0 defines as an empty square)
        self.grid = grid
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
        with open(file, 'r') as datafile:
        #read the file with a comma delimiter
            reader = csv.reader(datafile, delimiter=',', skipinitialspace=True)
            #define the grid as an empty array
            grid=[]
            #for each row in the file, append to the grid
            for row in reader:
                grid.append([int(x) for x in row])
            #this allows it to be read in as an int instead of a string
        return grid
        
    #Checks constraints -> 3x3 no dups, rows no dupes, no dupes
    def rule_check(self, row, col, val, grid):
        # Check Row
        for c in range(9):
            if c != col and grid[row][c] == val:
                return False
        # Check Column
        for r in range(9):
            if r != row and grid[r][col] == val:
                return False

        #Check 3x3
        box_row = (row // 3)*3
        box_col = (col // 3)*3

        for r in range(box_row, box_row + 3):
            for c in range(box_col, box_col + 3):#loop over the 2D array
                if(r != row or c != col) and grid[r][c] == val:
                    return False
                
        return True

class SudokuGui:
    def __init__(self,main,grid):
        self.main = main
        self.main.title("Sudoku Puzzle Solver")
        self.main.geometry("560x625") #Size

        #Creating the sudoku board
        self.grid = grid
        self.boxes = []

        #loop round to create the grid
        for r in range(9):
            row_cell = []
            for c in range(9):
                value = self.grid[r][c]

                #if the value is 0 show as blank
                text = str(value) if value != 0 else " "
                #Label Setup
                label = tk.Label(main, text=text, width=4, height=2, font=("Ariel", 18), relief="solid", borderwidth=1)
                label.grid(row=r, column=c, padx=1, pady=1)
                #row cells
                row_cell.append(label)
            self.boxes.append(row_cell)

        solve_button = tk.Button(root,text="Solve Puzzle",command=self.solve_puzzle, bg="#4CAF50",fg="white",
                                 font=("Arial", 14, "bold"),width=15,height=2,relief="raised",
                                 borderwidth=4,activebackground="#45a049",  activeforeground="yellow")#Styling button because why not.
        solve_button.grid(row=10, column=0, columnspan=9, pady=10)#Centered

    def update_grid(self, newGrid):
        #Updates the grid with new grid values
        for r in range(9):
            for c in range(9):
                value = newGrid[r][c]
                self.boxes[r][c].config(text=str(value) if value !=0 else " ")

    def solve_puzzle(self):
        print("Solve button clicked!")
        # backtracking function here with the use of the rule check.

#main
grid = SudokuCSP.get_puzzle("test.csv")
sudoku = SudokuCSP(grid, {})   
# create the board
root = tk.Tk()
gui = SudokuGui(root, grid)
root.mainloop()

#test cases
'''
print(sudoku.rule_check(0, 2,1, grid)) #should return True
print(sudoku.rule_check(0, 2,5, grid)) #should return False
'''
