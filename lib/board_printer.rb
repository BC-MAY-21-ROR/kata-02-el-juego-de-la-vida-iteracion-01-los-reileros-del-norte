require 'colorize'

module PrinterGame
  def welcome
    puts '=========== Welcome to Game of Life ==========='.blue
  end

  def grid_inputs
    welcome
  end

  def print_board(board)
    board.each do |row|
      row.each do |cell|
        print cell.to_s
      end
      puts
    end
    puts
  end
end
