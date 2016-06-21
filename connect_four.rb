class Grid
	attr_accessor :placements

	def initialize
		@placements = Array.new(6) {Array.new(7, " ")}
	end

	def layout
		output = ""
		(0..5).each do |row| 
			(0..6).each do |col|
				output << "|#{@placements[row][col]}"
			end
			output << "|\n"
		end
		output << "TTTTTTTTTTTTTTT\n 1 2 3 4 5 6 7"
		output
	end

	def drop(token, column)
		added = false
		5.downto(0).each do |row|
			if @placements[row][column] == " "
				@placements[row][column] = token 
				added = true
				break
			end
		end
		added
	end

	def check_winner
		winner = " "
		r = check_rows
		c = check_columns
		d = check_diagonals
		if r != " "
			winner = r 
		elsif c != " "
			winner = c 
		elsif d != " "
			winner = d 
		end
		winner
	end

	def moves_remaining?
		remaining = false
		(0..6).each do |i|
			if @placements[0][i] == " "
				remaining = true
				break
			end
		end
		return remaining
	end

	def check_rows
		winner = " "
		(0..5).each do |row|
			(0..3).each do |col|
				current = @placements[row][col]
				if current != " " &&
					current == @placements[row][col+1] &&
					current == @placements[row][col+2] &&
					current == @placements[row][col+3]
						winner = current
						break
				end
			end
		end
		winner
	end

	def check_columns
		winner = " "
		(0..2).each do |row|
			(0..6).each do |col|
				current = @placements[row][col]
				if current != " " &&
					current == @placements[row+1][col] &&
					current == @placements[row+2][col] &&
					current == @placements[row+3][col]
						winner = current
						break
				end
			end
		end
		winner
	end

	def check_diagonals
		winner = ""
		(0..2).each do |row|
			(0..3).each do |col|
				current = @placements[row][col]
				if current != " " &&
					current == @placements[row+1][col+1] &&
					current == @placements[row+2][col+2] &&
					current == @placements[row+3][col+3]
						winner = current
						break
				end
			end
		end
		(0..2).each do |row|
			(3..6).each do |col|
				current = @placements[row][col]
				if current != " " &&
					current == @placements[row+1][col-1] &&
					current == @placements[row+2][col-2] &&
					current == @placements[row+3][col-3]
						winner = current
						break
				end
			end
		end
		winner
	end

end

class Game
	attr_reader :move, :current_player

	def initialize
		puts "Welcome to Connect Four!"
		start_game
	end

	def start_game
		grid = Grid.new
		@current_player = 'O'
		while (grid.check_winner == '' && grid.moves_remaining?) do
			puts "Player #{@current_player}, your turn:"
			@move = gets.chomp
			if @move == 'q'
				break
			end
			grid.drop(@current_player, @move.to_i - 1)
			puts grid.layout
			swap_player
		end
		winner = grid.check_winner
		if winner != ''
			puts "Player #{winner} wins!"
		end
	end

	def swap_player
		if @current_player == 'O'
			@current_player = 'X'
		else
			@current_player = 'O'
		end
	end
end

Game.new