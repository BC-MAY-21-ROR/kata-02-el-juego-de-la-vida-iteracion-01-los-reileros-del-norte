class Cell
  def initialize
    @is_alive = false
  end

  def kill
    @is_alive = false
  end

  def vivify
    @is_alive = true
  end

  def to_s
   if @is_alive == true
     '*'    
   else
     '.'
   end
  end

  def alive?
    @is_alive
  end

end
