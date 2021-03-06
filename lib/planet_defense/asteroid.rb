module PlanetDefense
  class Asteroid < Chingu::GameObject
	 attr_accessor :vel_x, :vel_y, :frags, :x, :y
	 
    def initialize(window)    
    
      #Getting window dimensions
      @screenWidth = $window.width  
      @screenHeight = $window.height  
    
      #Give asteroid random image
      @imageNum = rand(3) + 1
      @image = $window.media_loader.asteroid["asteroid" + @imageNum.to_s]

      #Asteroids start at top, with random x and angle
      @x = rand(@screenWidth * 1.5) - (@screenWidth * 0.25)  
      @y = -50  
      @angle = rand(360)  
      @vel_angular = rand(2) + 1  
      #vel_y can be positive (down only)
      @vel_x = @vel_y = rand($window.options.asteroid_max_velocity - 1) + 1  
      #vel_x can be positive or negative (left or right)
      if (rand(2) == 1)
        @vel_x *= -0.15  
      end
      #vel_angular can be positive or negative (left or right spin)
      if (rand(2) == 1)
        @vel_angular *= -1  
      end
    end
  
    def on_collision   
      #puts "#{self.class} #{self.x}/#{self.y}"

		@expl_options = { :x => @x, :y => @y, :imageNum => @imageNum }
		PlanetDefense::Explosion.create( @expl_options );
		
		self.reset
      # PlayState.asteroids.delete self
      # PlayState.asteroids.push( Asteroid.new($window) )
    end
  
    def move
      @x += @vel_x  
      @y += @vel_y  
      @angle += @vel_angular  
    
    end
  
    def draw
      @image.draw_rot(@x, @y, 2, @angle)
    end
  
    def reset
      @y = 0
      @x = rand(@screenWidth)
    end
  end
end
