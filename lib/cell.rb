class Cell
  def initialize(cell = nil)
    @is_alive = if cell.nil?
                  false
                else
                  cell.alive?
                end
  end

  def copy
    Cell.new(self)
  end

  def kill
    @is_alive = false
  end

  def vivify
    @is_alive = true
  end

  def to_s
    if @is_alive
      '*'
    else
      '.'
    end
  end

  def alive?
    @is_alive
  end

  def dead?
    !alive?
  end
end
