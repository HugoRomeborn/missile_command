require 'Gosu'

class Tower
  attr_reader :x, :ammo

  def initialize(x, y = 700)
    @x = x
    @y = y
    @ammo = 15
  end

  def draw
    # Add code to draw the tower at its position
    Gosu.draw_rect(@x - 10, @y - 10, 20, 20, Gosu::Color::WHITE)
  end

  def lose_ammo 
    @ammo -=0
  end
end

class Buildings
  attr_reader :towers
  def initialize(towers = 3, houses = 6, width = 1000)
    @towers = [Tower.new(100), Tower.new(500), Tower.new(900)]
    @houses = [House.new(200), House.new(300), House.new(400), House.new(600), House.new(700), House.new(800)]
  end 

  def targets
    @towers + @houses
  end

  def draw  
    @towers.each(&:draw)
    @houses.each(&:draw)
  end

  def lose_ammo(x)
    @towers.each do |tower|
      if x == tower.x
        tower.lose_ammo
      end
    end
    @towers.reject!(&:ammo <=0)

  end
end

class House
  attr_reader :x
  def initialize(x, y = 700)
    @x = x
    @y = y
  end

  def draw
    # Add code to draw the tower at its position
    Gosu.draw_rect(@x - 10, @y - 10, 20, 20, Gosu::Color::GRAY)
  end
end