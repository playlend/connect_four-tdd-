require 'spec_helper'
require 'connect'

describe Game do

	context "when game created" do
		it "initializes two players" do
			game = Game.new()
			expect(game.player1).to eq("X")
			expect(game.player2).to eq("O")
		end
	end

	describe ".create_grid" do
		context "when we call the method" do
			it "creates an array" do
				game = Game.new()
				grid = Array.new(6) { Array.new(7) { |i| i } }
				expect(game.create_grid).to eq(grid)
			end
		end

	end

	describe ".check_input" do
		context "when location passed to the method" do
			it "will return true or false depending on the ability to place a value" do
				game = Game.new()
				game.create_grid
				loc = [5,1]
				expect(game.check_input(loc)).to eq(true)
			end
		end 
	end

	describe ".game_over" do
		game = Game.new()
		game.create_grid
		
		context "when four cells in a row have the same value" do
			it "returns true" do
				game.grid[5][3] = "O"
				game.grid[5][4] = game.grid[5][3]
				game.grid[5][5] = game.grid[5][3]
				game.grid[5][6] = game.grid[5][3]
				expect(game.game_over).to eq(true)
			end
		end

		context "when four cells in a column have the same value" do
			it "returns true" do
				game.grid[5][0] = "X"
				game.grid[4][0] = game.grid[5][0]
				game.grid[3][0] = game.grid[5][0]
				game.grid[2][0] = game.grid[5][0]
				expect(game.game_over).to eq(true)
			end
		end

		context "when four diagonal cells have the same value" do
			it "returns true" do
				game.grid[5][3] = "O"
				game.grid[4][4] = "O"
				game.grid[3][5] = "O"
				game.grid[2][6] = "O"
				expect(game.game_over).to eq(true)
			end
		end

		context "when all cells are filled" do
			it "returns true" do

				6.times do |num|
					7.times do |num2|
						game.grid[num][num2] = "O"
					end	
				end				
				expect(game.game_over).to eq(true)

			end
		end


	end
end