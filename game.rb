require 'Gosu'
require_relative 'libraries/missile.rb'

class Game < Gosu::Window

  def initialize()
    super 1000, 800
    self.caption = "Missile Command"
    @attacking_missiles = []
    @defensive_missiles = []
    @explosions = []

    10.times do
      @attacking_missiles << Offensive_missile.new(400)
    end
  end

  def button_down(id)
    if id == 256
      @defensive_missiles << Defensive_missiles.new(300, mouse_x, mouse_y)
    end

  end


  def update()
    @defensive_missiles.each {|missile| missile.update}
    hit = @defensive_missiles.select {|missile| missile.hit?}
    @explosions += hit.map do |missile| 
      Explosion.new(missile.x, missile.y)
    end

    @defensive_missiles = @defensive_missiles - hit
    # add new missiles


    # check if missile should keep existing
    @attacking_missiles.each {|missile| missile.update}
    hit = @attacking_missiles.select {|missile| missile.hit?}
    @explosions += hit.map do |missile| 
      Explosion.new(missile.x, missile.y)
    end

    @attacking_missiles = @attacking_missiles - hit

    @explosions.each {|explosion| explosion.update}
    @explosions.reject! {|explosion| explosion.size == 100}
  end

  def draw()
    @attacking_missiles.each do |missile|
      missile.draw
    end
    @defensive_missiles.each do |missile|
      missile.draw
    end
    @explosions.each do |explosion|
      explosion.draw
    end
  end


end


game = Game.new.show