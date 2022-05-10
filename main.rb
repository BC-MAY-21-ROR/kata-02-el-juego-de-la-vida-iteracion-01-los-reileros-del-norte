require './lib/grid'
require './lib/cell'

class Game
  include PrinterGame

  def initialize
    @board = []
  end

  def start
    puts 'select a number of rows'.yellow
    @rows = gets.chomp.to_i
    puts 'select a number of columns'.yellow
    @columns = gets.chomp.to_i

    generate_board
    print_board @board
    initial_cell
    puts "\n"
    print_board @board
  end

  def generate_board
    @board = Array.new(@rows){Array.new(@columns){Cell.new}}
  end

  def initial_cell
     middle_row = @rows/2
     middle_columns = @columns/2
     @board[middle_row][middle_columns].vivify
     @board[middle_row-1][middle_columns-1].vivify
     @board[middle_row-1][middle_columns].vivify
  end

  def next_generation
  end

end

game = Game.new
game.start
