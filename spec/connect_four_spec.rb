require './../lib/connect_four.rb'

describe "Board" do
    board = Board.new
    it "is always 7 wide" do
        expect(board.board.length).to eql(7)
    end

    it "is always 6 high" do
        expect(board.board[0].length).to eql(6)
    end

    describe "#place" do
        it "places a piece in a specified location" do
            board.board[0][0] = nil
            board.place(0, "red")
            expect(board.board[0][0]).to eql("red")
        end

        it "places a piece on top of another" do
            board.board[0][0] = "blue"
            board.place(0, "red")
            expect(board.board[0][1]).to eql("red")
        end

        it "only lets pieces be put in open spaces" do
            board.board[0].fill("red")
            expect(board.place(0,"red")).to eql("Please enter a valid location")
        end
    end

    describe "#check_win" do
        it "checks for horizontal win" do
            board = Board.new
            i = 0
            4.times do
                board.place(i, "red")
                i += 1
            end
            expect(board.check_win).to eql(true)
        end

        it "checks for vertical win" do
            board = Board.new
            4.times do
                board.place(0, "red")
            end
            expect(board.check_win).to eql(true)
        end

        it "checks for diagonal-up win" do
            board = Board.new
            i = 0
            4.times do
                board.board[i][i] = "red"
                i += 1
            end
            expect(board.check_win).to eql(true)
        end

        it "checks for diagonal-down win" do
            board = Board.new
            column = 0
            row = 3
            4.times do
                board.board[column][row] = "red"
                column += 1
                row -= 1
            end
            expect(board.check_win).to eql(true)
        end
    end


end