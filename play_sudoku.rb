require_relative "board"
require_relative "tile"

class Play_Sudoku

    # Input position
    def self.get_pos
        within_range = false

        until within_range
            print "Enter a position (e.g., 1 2): "
            pos = gets.chomp.split(" ")
            pos.map!{ |ele| ele.to_i }

            # Checks if the position entered is in range of the board
            if pos.count == 2
                within_range = pos.all? { |ele| ele >= 0 && ele <= 8 }
            end
            
        end
        return pos
    end

    # Input value
    def self.get_val
        valid_val = false

        until valid_val
            print "Enter a number from 0 to 9: "
            val = gets.chomp
            
            # Checks if the value entered is within range
            if val.length == 1
                valid_val = true if val.to_i >=0 && val.to_i <= 9
            end
        end

        return val.to_i
    end

   if __FILE__ == $PROGRAM_NAME
        board = Board.new()
        board.from_file

        until board.game_won?
            pos = Play_Sudoku.get_pos
            val = Play_Sudoku.get_val

            board[pos]=val
            board.render()
        end
   end
end    

    