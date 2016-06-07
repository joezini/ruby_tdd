require 'spec_helper'

empty_layout = %Q(| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
TTTTTTTTTTTTTTT
 1 2 3 4 5 6 7)
layout_with_one_token = %Q(| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | |O| | | |
TTTTTTTTTTTTTTT
 1 2 3 4 5 6 7)
layout_with_a_few_tokens = %Q(| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
| |O|O| | | | |
| |X|X|O| | | |
TTTTTTTTTTTTTTT
 1 2 3 4 5 6 7)			
empty_placements = Array.new(6) {Array.new(7, " ")}

describe Grid do
	context "with new grid" do
		before :each do
			@grid = Grid.new
		end

		it "displays an empty grid" do
			expect(@grid.layout).to eq(empty_layout)
		end
		it "creates an empty token array" do
			expect(@grid.placements).to eq(empty_placements)
		end
		it "displays a game token" do
			@grid.placements[5][3] = "O"
			expect(@grid.layout).to eq(layout_with_one_token)
		end
		it "displays a few game tokens" do
			@grid.placements[5][3] = "O"
			@grid.placements[5][2] = "X"
			@grid.placements[4][2] = "O"
			@grid.placements[5][1] = "X"
			@grid.placements[4][1] = "O"
			expect(@grid.layout).to eq(layout_with_a_few_tokens)
		end
		it "drops a token to the correct placement" do
			@grid.drop("O", 3)
			expect(@grid.placements[5][3]).to eq("O")
		end
		it "shows dropped token" do
			@grid.drop("O", 3)
			expect(@grid.layout).to eq(layout_with_one_token)
		end
		it "doesn't add a token to a full column" do
			@grid.drop("X", 3)
			@grid.drop("X", 3)
			@grid.drop("X", 3)
			@grid.drop("X", 3)
			@grid.drop("X", 3)
			@grid.drop("X", 3)
			expect(@grid.drop("O", 3)).to be false
			expect(@grid.placements[0][3]).to eq("X")
		end
		it "finds a winning row" do
			@grid.drop("X", 1)
			@grid.drop("X", 2)
			@grid.drop("X", 3)
			@grid.drop("X", 4)
			expect(@grid.check_rows).to eq("X")
		end
		it "finds a winning column" do
			@grid.drop("O", 1)
			@grid.drop("O", 1)
			@grid.drop("O", 1)
			@grid.drop("O", 1)
			expect(@grid.check_columns).to eq("O")
		end
		it "finds a winning diagonal" do
			@grid.placements[1][1] = "X"
			@grid.placements[2][2] = "X"
			@grid.placements[3][3] = "X"
			@grid.placements[4][4] = "X"
			expect(@grid.check_diagonals).to eq("X")
		end
		it "finds a winner" do
			@grid.placements[0][6] = "O"
			@grid.placements[1][5] = "O"
			@grid.placements[2][4] = "O"
			@grid.placements[3][3] = "O"
			expect(@grid.check_winner).to eq("O")
		end
	end
end

describe Game do
	describe '#initialize' do
		it "prints 'Welcome to Connect Four!' to the screen" do
			# game = instance_double('Game')
			#expect(Game).to receive(:fake_start_game).and_return("Fake game start successfully mocked")
			
			expect(STDOUT).to receive(:puts).with("Welcome to Connect Four!")
			expect_any_instance_of(Game).to receive(:start_game)
			Game.new 
		end
	end

	describe '#start_game' do
		xit "accepts input from the first player and prints the new layout" do
			expect(STDOUT).to receive(:puts).with("Welcome to Connect Four!")
			expect(STDOUT).to receive(:puts).with("Player O, your turn:")
			expect(subject).to receive(:gets).and_return("4\n")
			expect(STDOUT).to receive(:puts).with(layout_with_one_token)
			expect(STDOUT).to receive(:puts).with("Player X, your turn:")
			expect(subject).to receive(:gets).and_return("q\n")
			subject.start_game
			#expect(subject.instance_variable_get(:@move)).to eq("4")
		end
	end
end