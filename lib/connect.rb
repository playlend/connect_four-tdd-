class Game
	attr_accessor :player1, :player2, :grid

	def initialize
		@player1 = "X"
		@player2 = "O"
	end

	# private
	def create_grid
		@grid = Array.new(6) { Array.new(7) { |i| i } }
	end

	def show_grid
		counter = -1
		@grid.each { |element| print "Level #{counter+=1}: "; p element }
	end	

	def check_input(location)
		# check if the input within the grid
		if (location[0] >= 0 && location[0] <=5) & (location[1]>=0 && location[1] <=6)
			# check if the place vacant	
			if location[1] == @grid[location[0]][location[1]]
				# check if the bottom has a value
				if (location[0] == 5) || (((@grid[location[0]+1][location[1]]) == @player1) || ((@grid[location[0]+1][location[1]]) == @player2))
 					true
 				else
 					false
 				end
			else
				false
			end
		else
			false
		end

	end

	def game_over
		# setting up test arrays
		test1 = [@player1,@player1,@player1,@player1]
		test2 = [@player2,@player2,@player2,@player2]

		found = false
		# horizontal check
		@grid.each do |arr|
			if (arr[0..3] == test1) || (arr[0..3] == test2)
				return found = true
			elsif (arr[-4..-1] == test1) || (arr[-4..-1] == test2)
				return found = true
			elsif (arr[1..4] == test1) || (arr[1..4] == test2)
				return found = true
			elsif (arr[2..5] == test1) || (arr[2..5] == test2)
				return found = true		
			end
				
		end

		#vertical check
		test_arr = []
		7.times do |num|
			6.times do |num2|
				test_arr.push(@grid[num2][num])
			end
			# checking for the range
			if (test_arr[0..3] == test1) || (test_arr[0..3] == test2)
				return found = true
			elsif (test_arr[1..4] == test1) || (test_arr[1..4] == test2)
				return found = true
			elsif (test_arr[2..5] == test1) || (test_arr[2..5] == test2)
				return found = true
			end
			test_arr = []
		end

		#diagonal check
		test_arr = []
		3.times do |num|
			#one half
			test_arr = []
			(num..num+3).collect { |num2| test_arr << @grid[num2][num2] } 
			return true if (test_arr == test1) || (test_arr == test2)

			test_arr = []
			(num..num+3).collect { |num2| test_arr << @grid[num2][num2+1] } 
			return true if (test_arr == test1) || (test_arr == test2)

			#the other half
			counter = 5 - num
			test_arr = []
			(num..num+3).collect { |num2| test_arr << @grid[num2][counter]; counter-=1 } 
			return true if (test_arr == test1) || (test_arr == test2)

			counter = 6 - num
			test_arr = []
			(num..num+3).collect { |num2| test_arr << @grid[num2][counter]; counter-=1 } 
			return true if (test_arr == test1) || (test_arr == test2)

		end

		2.times do |num|
			#one half
			test_arr = []
			(num+1..num+4).collect { |num2| test_arr << @grid[num2][num2-1] }
			return true if (test_arr == test1) || (test_arr == test2)

			test_arr = []
			(num..num+3).collect { |num2| test_arr << @grid[num2][num2+2] }
			return true if (test_arr == test1) || (test_arr == test2)


			#the other half
			counter = 4 - num
			test_arr = []
			(num..num+3).collect { |num2| test_arr << @grid[num2][counter]; counter-=1 }
			return true if (test_arr == test1) || (test_arr == test2)

			counter = 6 - num
			test_arr = []
			(num+1..num+4).collect { |num2| test_arr << @grid[num2][counter]; counter-=1 }
			return true if (test_arr == test1) || (test_arr == test2)


		end

		1.times do |num|
			#one half
			test_arr = []
			(num+2..num+5).collect { |num2| test_arr << @grid[num2][num2-2] }
			return true if (test_arr == test1) || (test_arr == test2)

			test_arr = []
			(num+3..num+6).collect { |num2| test_arr << @grid[num2-3][num2] }
			return true if (test_arr == test1) || (test_arr == test2)

			#the other half
			counter = 3
			test_arr = []
			(num..num+3).collect { |num2| test_arr << @grid[num2][counter]; counter-=1 }
			return true if (test_arr == test1) || (test_arr == test2)

			counter = 6
			test_arr = []
			(num+2..num+5).collect { |num2| test_arr << @grid[num2][counter]; counter-=1 }
			return true if (test_arr == test1) || (test_arr == test2)


		end

		#checking if all cells are filled
		found = true
		6.times do |num|
			7.times do |num2|
				if (@grid[num][num2] != @player1) || (@grid[num][num2] != @player2)
					found = false
				end
			end	
		end


		return found
	end	

	def prompt(turn)
		location = []
		print "#{turn}, please enter the level: "
		answer1 = gets.chomp
		answer1 = answer1.to_i

		print "Please, enter the number of the cell: "
		answer2 = gets.chomp
		answer2 = answer2.to_i

		location = [answer1,answer2]	 

		return location
	end
	
	#public
	def game_on
		create_grid
		turn = 1
		while !game_over
			if turn == 1
				show_grid
				location = prompt(@player1)

				if check_input(location)
					@grid[location[0]][location[1]] = @player1
					turn = 2
				else
					puts "Wrong location! Please, try again."
				end
			elsif turn == 2
				show_grid
				location = prompt(@player2)

				if check_input(location)
					@grid[location[0]][location[1]] = @player2
					turn = 1
				else
					puts "Wrong location! Please, try again."
				end
			end
		end	
		show_grid
	end

end