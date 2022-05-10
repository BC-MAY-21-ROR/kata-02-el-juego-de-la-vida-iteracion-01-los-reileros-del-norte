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
  end

  def generate_board
    @board = Array.new(@rows).map{|row| Array.new(@columns, Cell.new)}
  end

  def next_generation
  end

end

game = Game.new
game.start
