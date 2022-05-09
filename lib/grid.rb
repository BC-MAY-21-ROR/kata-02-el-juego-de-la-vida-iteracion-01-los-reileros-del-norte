require 'colorize'

module PrinterGame
  def welcome
    puts '=========== Welcome to Game of Life ==========='.blue
  end

  def grid_inputs
    welcome
    puts 'select a number of rows'.yellow
    rows = gets.chomp.to_i
    puts 'select a number of columns'.yellow
    columns = gets.chomp.to_i
    grid_template(rows, columns)

    [rows, columns].class
  end

  def grid_template(rows, columns)
    # board = []

    columns && rows.times do |row|
      puts '.' * row
    end
  end
end
