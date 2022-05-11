require './lib/board_printer'
require './lib/cell'

class Game
  include PrinterGame

  def initialize
    @board = []
  end

  def start
    @rows = 10
    @columns = 10

    generate_board
    initial_cells

    print_board(@board)

    50.times do
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
    snapshot = board_snapshot

    @board.each_with_index do |idx_row, idx_r|
      idx_row.each_with_index do |cell, idx_c|
        neighbours_count = alive_neighbours_count(snapshot, idx_r, idx_c)
        apply_rules(cell, neighbours_count)
      end
    end
  end

  def apply_rules(cell, alive_neighbours_count)
    first_rule(cell, alive_neighbours_count)
    second_rule(cell, alive_neighbours_count)
    third_rule(cell, alive_neighbours_count)
    fourth_rule(cell, alive_neighbours_count)
  end

  def first_rule(cell, alive_neighbours_count)
    cell.kill if alive_neighbours_count < 2
  end

  def second_rule(cell, alive_neighbours_count)
    cell.kill if alive_neighbours_count > 3
  end

  def third_rule(cell, alive_neighbours_count)
    return if cell.dead?

    cell.vivify if [2, 3].include?(alive_neighbours_count)
  end

  def fourth_rule(cell, alive_neighbours_count)
    cell.vivify if alive_neighbours_count == 3
  end

  def alive_neighbours_count(board_snapshot, idx_row, idx_col)
    alive_neighbours_count = 0
    [idx_row - 1, idx_row, idx_row + 1].each do |r|
      [idx_col - 1, idx_col, idx_col + 1].each do |c|
        next if r.negative? || r >= @rows
        next if c.negative? || c >= @columns
        next if idx_row == r && idx_col == c

        alive_neighbours_count += 1 if board_snapshot[r][c].alive?
      end
    end
    alive_neighbours_count
  end

  def board_snapshot
    board_snapshot = []
    @board.each_with_index do |row, idx_row|
      board_snapshot << []
      row.each do |cell|
        board_snapshot[idx_row] << cell.copy
      end
    end
    board_snapshot
  end
end

game = Game.new
game.start
