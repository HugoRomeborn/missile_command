class Missile
  #macron
  attr_reader :x, :y
  
  def hit?(explosions)
    if @x == @target_x && @y == @target_y || in_explosion(explosions)
      return true
    end 
    false
  end

  def in_explosion(explosions)
    explosions.each do |explosion|
      if @x > explosion.x - (explosion.size)/2 && @x < explosion.x + (explosion.size)/2 && @y > explosion.y - (explosion.size) /2 && @y < explosion.y + (explosion.size)/2
        return true
      end
    end
    false
  end

  def speed_calculator()
    @angle = Math.atan((@target_y-@y)/(@target_x-@x))
    
    if @target_x < @x
      @angle += 3.14159265359
    end
    @vel_x = Math.cos(@angle) * @speed
    @vel_y = Math.sin(@angle) * @speed
  end

  def update()
    @x += @vel_x
    @y += @vel_y
    
  
    if at_target?()
      @x = @target_x
      @y = @target_y
    end  
  end

  def draw()
    @missile.draw_rot(@x - Math.sin(@angle) * 15, @y - Math.cos(@angle) * 15, 1, @angle*360/(2*3.14159265359), 1, 0.5, 0.1, 0.1)
  end
end


class Offensive_missile < Missile
  
  @@targets = [100, 500, 900, 200, 300, 400, 600, 700, 800]
  
  def initialize(speed)
    @missile_type = :offensive
    @speed = speed

    @missile = Gosu::Image.new('media/IMG/missile_2.png')

    #chose target and starting position
    @target_x = @@targets[rand(9)] 
    @target_y = 700
    @x = @target_x + rand(801) -400.1
    if @x < 0
      @x=0
    elsif @x > 1000
      @x = 1000
    end
    @y = 0

    speed_calculator()
  end

  def at_target?
    @y >= @target_y
  end
end



class Defensive_missiles < Missile

  @@gun_towers =  [
    {
      id: 0,
      ammo: 15,
      position: 100
    }, 
    {
      id: 1,
      ammo: 15,
      position: 500
    }, 
    {
      id: 2,
      ammo: 15,
      position: 900
    }
  ]

  def initialize(speed, target_x, target_y)
    @speed = speed

    @missile = Gosu::Image.new('media/IMG/missile_2.png')

    #chose target and starting position
    @target_x = target_x
    @target_y = target_y
    @x = @@gun_towers[choose_tower()][:position]
    @y = 700

    speed_calculator()
  end

  def choose_tower()
    smallest = @@gun_towers[0]
    @@gun_towers.each_with_index do |tower, i|
      if (tower[:position] - @target_x).abs < (smallest[:position] - @target_x).abs
        smallest = tower
      end
    end
    @@gun_towers[smallest[:id]][:ammo] -= 1
    if @@gun_towers[smallest[:id]][:ammo] == 0
      @@gun_towers.delete_at(smallest[:id])
    end
    smallest[:id]
  end

  def at_target?
    @y <= @target_y
  end
end

class Explosion 

  attr_reader :size, :x, :y
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