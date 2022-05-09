require './lib/grid'
class Game
  include PrinterGame

  def initialize
  end

  def start
    return grid_inputs
  end
end

game = Game.new
puts game.start
