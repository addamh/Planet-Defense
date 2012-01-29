GAMEROOT = File.dirname(File.expand_path($0))
require 'rubygems' unless RUBY_VERSION =~ /1\.9/
require 'chingu'
include Gosu
include Chingu
require_all  File.join(GAMEROOT,"classes")

class Asteroids < Chingu::Window
  attr_accessor :music, :screenWith, :screenHeight, :window, :object_factor

  def initialize
    retrofy
    
    @screenWidth = 1024  
    @screenHeight = 768 
    @object_factor = 2.5 
    super(@screenWidth, @screenHeight, false)  
    self.caption = "Planetary Defense"  
    self.input = { :f1 => :debug, [:q, :escape] => :exit }
    @directions_to_xy = { :north => [0, -1], :east => [1, 0], :south => [0, 1], :west => [-1, 0] }
    push_game_state( PlayState )
  end
  
  def debug   
     push_game_state(Chingu::GameStates::Debug.new)
  end
  
  def width
    return @screenWidth  
  end
  
  def height
    return @screenHeight  
  end
  
  def directions_to_xy(directions = nil)
    x, y = 0, 0
    return [x,y]  unless directions
    directions.each do |direction, boolean|
      if boolean
        x += @directions_to_xy[direction][0]
        y += @directions_to_xy[direction][1]
      end
    end 
    return [x,y]
  end
  
end

g = Asteroids.new
g.show