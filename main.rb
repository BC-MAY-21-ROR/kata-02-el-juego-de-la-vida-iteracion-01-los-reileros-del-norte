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
    initial_cells

    print_board(@board)

    20.times do |_i|
      next_generation
      print_board(@board)
      sleep(1)
    end
  end

  def generate_board
    @board = Array.new(@rows) { Array.new(@columns) { Cell.new } }
  end

  def initial_cells
    middle_row = @rows / 2
    middle_columns = @columns / 2
    @board[middle_row][middle_columns].vivify
    @board[middle_row - 1][middle_columns].vivify
    @board[middle_row + 1][middle_columns].vivify
    @board[middle_row][middle_columns - 1].vivify
    @board[middle_row - 1][middle_columns + 1].vivify
  end

  def next_generation
    copy_board = snapshot
    @board.each_with_index do |row, r|
      row.each_with_index do |cell, c|
        neighbours_count = alive_neighbours_count(copy_board, r, c)
        apply_rules(cell, neighbours_count)
      end
    end
  end

  def apply_rules(cell, neighbours_count)
    first_rule(cell, neighbours_count)
    second_rule(cell, neighbours_count)
    thrid_rule(cell, neighbours_count)
    fourth_rule(cell, neighbours_count)
  end

  def first_rule(cell, neighbours_count)
    cell.kill if neighbours_count < 2
  end

  def second_rule(cell, neighbours_count)
    cell.kill if neighbours_count > 3
  end

  def thrid_rule(cell, neighbours_count)
    return if cell.dead?

    cell.vivify if neighbours_count == 2 && neighbours_count == 3
  end

  def fourth_rule(cell, neighbours_count)
    cell.vivify if neighbours_count == 3
  end

  def alive_neighbours_count(snapshot, row, col)
    neighbours_count = 0
    [row - 1, row, row + 1].each do |r|
      [col - 1, col, col + 1].each do |c|
        next if r.negative? || r >= @rows
        next if c.negative? || c >= @columns

        neighbours_count += 1 if snapshot[r][c].alive?
      end
    end
    neighbours_count
  end

  def snapshot
    snapshot = []
    @board.each_with_index do |row, idx|
      snapshot << []
      row.each do |cell|
        snapshot[idx] << cell.copy
      end
    end
    snapshot
  end
end

game = Game.new
game.start
