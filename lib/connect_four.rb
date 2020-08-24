class Board

    attr_reader :board, :player1, :player2, :player_one_turn, :won
    attr_accessor :board, :player_one_turn, :won

    def initialize
        generate_board
        @player_one_turn = true
        @won = false
        
    end

    def generate_board
        #Makes a game board from an array of arrays, always 7 wide, 6 high
        @board = Array.new(7) {|i| Array.new(6)}
    end

    def place(column, color)
        slot = board[column].find_index {|i| i == nil}
        if slot == nil
            return "Please enter a valid location"
        else
            board[column][slot] = color
        end
    end

    def check_win

        player_one_win = [@player1,@player1,@player1,@player1]
        player_two_win = [@player2,@player2,@player2,@player2]

        board.each_with_index do |column, index|
            column.each_with_index do |piece, row|
                vert_check = [piece, column[row+1], column[row+2],column[row+3]]
                ho_check = [piece, board[index+1][row], board[index+2][row], board[index+3][row]]
                diag_up_check = [piece, board[index+1][row+1], board[index+2][row+2], board[index+3][row+3]]
                diag_down_check = []
                if row >= 3
                    diag_down_check = [piece, board[index+1][row-1], board[index+2][row-2], board[index+3][row-3]]
                end

                if vert_check == (player_one_win || player_two_win) || ho_check == (player_one_win || player_two_win) || diag_up_check == (player_one_win || player_two_win) || diag_down_check == (player_one_win || player_two_win) 
                    @won = true
                    return
                end
                
            end
        end
        return false
    end

    def display_board
        rows = 6..0
        (rows.first).downto(rows.last).each do |i|
            row_display = []
            board.each do |column|
                
                if column[i] == nil
                    row_display.push("")
                else
                    row_display.push(column[i])
                end
                
            end
            puts row_display.join(" | ")
        end    
    end

    def player_choice
        puts "Player 1, choose your symbol"
        @player1 = gets.chomp
        puts "Player 2, choose your symbol"
        @player2 = gets.chomp
    end

    def turn
        puts "Please select a column to place your piece in"
        choice = gets.chomp
        if player_one_turn
            place(choice.to_i, player1)
        else
            place(choice.to_i, player2)
        end
        player_one_turn = !player_one_turn
    end

    def play
        player_choice
        display_board
        while !won
            turn
            display_board
            check_win
        end
        puts "game over!"
        if player_one_turn
            puts "Player 1 wins!"
        else
            puts "Player 2 wins!"
        end
    end
end
