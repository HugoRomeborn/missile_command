class Missile
  #macron
  attr_reader :x, :y
  
  def hit?
    if @x == @target_x && @y == @target_y
      return true
    else 
      return false
    end
  end

  def update()
    @x += @vel_x
    @y += @vel_y
    
    if @y <= @target_y
      @x = @target_x
      @y = @target_y
    end
  end

  def draw()
    @missile.draw(@x, @y, 1, 0.1, 0.1)
  end
end


class Offensive_missile < Missile
  
  @@targets = [100, 500, 900, 200, 300, 400, 600, 700, 800]
  
  def initialize(speed)
    @speed = speed

    @missile = Gosu::Image.new('media/IMG/missile_2.png')

    #chose target and starting position
    @target_x = @@targets[rand(9)]
    @target_y = 700
    @x = @target_x + rand(401) -200
    if @x < 0
      @x=0
    elsif @x > 1000
      @x = 1000
    end
    @y = 0

    @vel_y = @target_y / @speed
    @vel_x = (@target_x - @x) / @speed.to_f
  end
end



class Defensive_missiles < Missile

  @@gun_towers =  [100, 500, 900]

  def initialize(speed, target_x, target_y)
    @speed = speed

    @missile = Gosu::Image.new('media/IMG/missile_2.png')

    #chose target and starting position
    @target_x = target_x
    @target_y = target_y
    @x = @@gun_towers[rand(3)]
    @y = 700

    @vel_y = (@target_y - @y) / @speed.to_f
    @vel_x = (@target_x - @x) / @speed.to_f
  end
end

class Explosion 

  attr_reader :size
  def initialize(x, y)
    @x = x
    @y = y
    @size = 20

    @explosion = Gosu::Image.new('media/IMG/circle(2).png')
  end

  def update()
    @size += 1
  end 

  def draw()
    x = @x-@size/2
    y = @y-@size/2
    @explosion.draw(x, y, 1, @size/225.to_f, @size/225.to_f)
  end

end