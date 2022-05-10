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
    initial_cell
  end

  def generate_board
    @board = Array.new(@rows) { Array.new(@columns) { Cell.new } }
  end

  def initial_cell
    middle_row = @rows / 2
    middle_columns = @columns / 2
    @board[middle_row][middle_columns].vivify
    @board[middle_row - 1][middle_columns - 1].vivify
    @board[middle_row - 1][middle_columns].vivify
  end

  # neighbours = [] neighbours<<(@board.cell(self.x - 1, self.y - 1))
  def next_generation
    neighbours = []
    @board.each_with_index do |row, r|
      row.each_with_index do |cell, c|
        alive_neighbours = alive_neighbours_count(r, c)
        apply_rules(cell, alive_neighbours.size)
      end
    end
    neighbours
  end

  def apply_rules(cell, alive_neighbours)

  end

  def alive_neighbours_count(row, c)
    # row - 1..n
    neighbours = []
     [row - 1, row, row + 1].each do |r|
      [c - 1, c, c + 1].each do |c|
        next if r.negative? || r >= @rows
        next if c.negative? || c >= @columns

        neighbours.push(true) if @board[r][c].alive?
      end
    end
    neighbours
  end
end

game = Game.new
game.start
