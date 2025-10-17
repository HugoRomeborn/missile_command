require 'Gosu'
require_relative 'libraries/missile.rb'
require_relative 'libraries/towers.rb'

class Game < Gosu::Window

  def initialize(missile_spawn_rate)
    super 1000, 800
    self.caption = "Missile Command"
    @attacking_missiles = []
    @defensive_missiles = []
    @explosions = []
    @missile_spawn_rate = missile_spawn_rate
    @buildings = Buildings.new()

    4.times do
      @attacking_missiles << Offensive_missile.new(1)
    end
  end

  def button_down(id)
    if id == 256
      @defensive_missiles << Defensive_missiles.new(10, mouse_x, mouse_y, @buildings)
    end

  end


  def update()
    @defensive_missiles.each {|missile| missile.update}
    hit = @defensive_missiles.select {|missile| missile.hit?(@explosions)}
    @explosions += hit.map do |missile| 
      Explosion.new(missile.x, missile.y)
    end

    @defensive_missiles = @defensive_missiles - hit
    # add new missiles

    if rand(1000) <= @missile_spawn_rate
      @attacking_missiles << Offensive_missile.new(1)
    end

    # check if missile should keep existing
    @attacking_missiles.each {|missile| missile.update}
    hit = @attacking_missiles.select {|missile| missile.hit?(@explosions)}
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
    @buildings.draw
  end


end


game = Game.new(8).show