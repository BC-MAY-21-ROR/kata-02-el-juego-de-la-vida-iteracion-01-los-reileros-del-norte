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
    p next_generation
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

  # neighbours = [] neighbours<<(@board.cell(self.x - 1, self.y - 1))
  def next_generation
    neighbours = []
    @board.each_with_index do |row, index|
      row.each_with_index do |cell, col|
        p alive_neighbours_count(index, col)
      end
    end
    neighbours
  end

  def alive_neighbours_count(row, col)
    # row - 1..n
    neighbours = []
    for row in [row-1, row, row+1]    # position Y
      for col in [col-1, col, col+1]  # position X
        if row > 0 && col > 0
          if @board[row][col].alive?
            neighbours.push(true)
          end
        end
      end
    end
    neighbours
  end

end

game = Game.new
game.start
