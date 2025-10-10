#Coursework 1 - Corey Yule, Euan Grierson 
#Part 1A

#Reference: https://www.geeksforgeeks.org/dsa/sudoku-backtracking-7/ <- this is for our report.

#Imports
import csv
import numpy as np
import tkinter as tk
from tkinter.filedialog import askopenfilename
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
    @staticmethod #So it can be called from the GUI
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
    @staticmethod #So it can be called from the GUI
    def rule_check(row, col, val, grid):
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
        self.main.geometry("600x760") #Size
        main.configure(bg='blue')
        self.counter = 0
        # Frame that will hold the Sudoku board
        board_frame = tk.Frame(self.main, bg="blue")
        board_frame.pack(expand=True)  # center the frame in the window

        #Creating the sudoku board
        self.grid = grid
        self.boxes = []

        #loop round to create the grid
        for r in range(9):
            row_cell = []
            for c in range(9):
                value = self.grid[r][c]
                text = str(value) if value != 0 else " "

                # Default borders
                top = 1
                left = 1
                right = 1
                bottom = 1

                # Make thick borders every 3 cells
                if r % 3 == 0:
                    top = 3
                if c % 3 == 0:
                    left = 3
                if r == 8:  # bottom edge of board
                    bottom = 3
                if c == 8:  # right edge of board
                    right = 3

                label_boxes = tk.Label(
                    board_frame,text=text,width=4,height=2,
                    font=("Ariel", 18),relief="solid",
                    bd=0  # disable default border so we can use highlight thickness
                )
                label_boxes.grid(
                    row=r,column=c,
                    padx=(left, right),
                    pady=(top, bottom)
                )

                row_cell.append(label_boxes)
            self.boxes.append(row_cell)

        #Label:
        # Label on the left
            self.backtrack_label = tk.Label(
            main,text=f"Backtracks: {self.counter}",bg=main["bg"] ,fg="white",
            font=("Arial", 14, "bold"), width=15, height=2, relief="raised",borderwidth=0
        )
        self.backtrack_label.pack(side="left", padx=10)

        #Buttons:
        # Solve button in the middle
        solve_button = tk.Button(main, text="Solve Puzzle", command=self.solve_puzzle_button,
                                bg="#4CAF50", fg="white", font=("Arial", 14, "bold"),
                                width=15, height=2, relief="raised",
                                borderwidth=4, activebackground="#45a049", activeforeground="yellow")
        solve_button.pack(side="left", expand=True, padx=10, pady=(0,20))

        # File button on the right
        file_button = tk.Button(main, text="Import Board", command=self.import_board,
                                bg="#4CAF50", fg="white", font=("Arial", 14, "bold"),
                                width=15, height=2, relief="raised",
                                borderwidth=4, activebackground="#45a049", activeforeground="lightblue")
        file_button.pack(side="right", padx=10, pady=(0,20))


    def update_grid(self, newGrid):
        #Updates the grid with new grid values
        for r in range(9):
            for c in range(9):
                value = newGrid[r][c]
                self.boxes[r][c].config(text=str(value) if value !=0 else " ")

            self.backtrack_label.config(text=f"Backtracks: {self.counter}")  # refresh label
            self.main.update_idletasks()  # force redraw

    def solve_puzzle(self, grid, row=0, col=0):
        #'''
        # GUI update + delay here (so you see each step)
        self.update_grid(grid)
        self.main.update_idletasks()
        self.main.after(1)  # 5 ms delay between steps this is just to see the process.
        #'''
        # If we've reached the end
        if row == 9:
            return True
        # If last column, move to next row
        if col == 9:
            return self.solve_puzzle(grid, row + 1, 0)
        # Skip filled cells
        if grid[row][col] != 0:
            return self.solve_puzzle(grid, row, col + 1)
        # Try numbers 1–9
        for num in range(1, 10):
            if SudokuCSP.rule_check(row, col, num, grid):
                grid[row][col] = num
                if self.solve_puzzle(grid, row, col + 1):
                    return True
                #Backtrack
                grid[row][col] = 0
                self.counter += 1 #increment backtracks this is for the count
        return False
    
    def solve_puzzle_button(self):
        if self.solve_puzzle(self.grid, 0, 0):
            self.update_grid(self.grid)
        else:
            print("No solution exists") # this should technically never happen...
    #This is for the import button resets the board to what is imported
    def import_board(self):
        filename = askopenfilename()
        grid = SudokuCSP.get_puzzle(filename)
        self.counter = 0 # reset the counter of each board
        self.grid = grid
        self.update_grid(grid)

#main
#grid setup
grid = [[0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0]]

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
