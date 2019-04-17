require 'colorize'
require_relative "tile"

class Board
    attr_reader :grid

    def initialize()
        @grid = Array.new(9){Array.new(9)}
    end

    def from_file
        arr = []
        File.readlines("puzzles/sudoku1_almost.txt").each do |line|
            line.chomp.each_char do |ele|
                arr << Tile.new(ele.to_i)
            end
        end
    
        @grid = arr.each_slice(9).to_a
        render()
    end

    # Change the value at the given position
    def []=(pos, val)
        row, col = pos
        tile = @grid[row][col]

        if !tile.given
            tile.value = val
        else
            puts
            puts "Cannot change a given value!".red
        end
    end

    # Check if each row has unique integers
    def uniq_rows
        uniq_ints = (1..9).to_a
        @grid.each do |subArr| 
            rows = []
            subArr.each do |tiles|
                rows << tiles.value
            end
            return false if rows.sum != 45
            return false if (rows.sort == uniq_ints) == false
        end 
    
        return true      
    end

    # Check if each column has unique integers
    def uniq_cols
        uniq_ints = (1..9).to_a      
        (0..8).each do |col|
            cols = []
            (0..8).each do |row|
                cols << @grid[row][col].value   
            end 
            return false if cols.sum != 45
            return false if (cols.sort == uniq_ints) == false
        end
        
        return true 
    end

    # Check if each 3x3 square has unique integers
    def uniq_sq()
        uniq_ints = (1..9).to_a 
        (0..8).each do |i|
            x = (i / 3) * 3
            y = (i % 3) * 3
            sq = []
            (x...x + 3).each do |row|
              (y...y + 3).each do |col|
                sq << @grid[row][col].value
              end
            end
            return false if sq.sum != 45
            return false if (sq.sort == uniq_ints) == false
        end

        return true 
    end
    
    # Sudoku puzzle solved if all three checks return true
    def game_won?
        if uniq_rows() && uniq_cols() && uniq_sq()
            puts "Sudoku Puzzle Solved!"
            return true
        end
        return false
    end

    # Render the sudoku board
    def render
        puts
        # cols index
        print "     "
        i = 0
        count = 0
        while i <= 8
            if count == 3
                print " "
                count = 0
            end
            count += 1
            print i
            i += 1
        end
        puts puts

        # rows        
        j = 0
        @grid.each_with_index do |subArr, i|  
            print " #{i}   "    
            i = 0
            subArr.each do |tile|
                if i == 3
                    print " "
                    i = 0
                end
                i += 1

                # print sudoku values
                if tile.given
                    print (tile.value.to_s).red
                else
                    print tile.value    
                end             
            end
            j += 1
            if j == 3
                puts
                j = 0
            end
            puts
        end
        puts "----------------------------" 
    end

end