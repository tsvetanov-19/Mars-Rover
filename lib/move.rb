require_relative '../config/constants'
require_relative './direction'
require_relative './point'
require_relative './rotation'


module Move
  include Constants
  include Rotation
  attr :dir
  attr :current_point


  # TODO: private methods for step_north, step_south etc
  def step_forward(point, direction)
    case direction.direction
    when 'south'
      if point.y_coord - 1 > MIN_Y
        Point.new(point.x_coord, point.y_coord - 1)
      else
        step_forward(point, flip_direction(direction))
      end
    when 'north'
      if point.y_coord + 1 < MAX_Y
        Point.new(point.x_coord, point.y_coord + 1)
      else
        step_forward(point, flip_direction(direction))
      end
    when 'west'
      if point.x_coord - 1 > MIN_X
        Point.new(point.x_coord - 1, point.y_coord)
      else
        step_forward(point, flip_direction(direction))
      end
    else # going 'east'
      if point.x_coord + 1 < MAX_X
        Point.new(point.x_coord + 1, point.y_coord)
      else
        step_forward(point, flip_direction(direction))
      end
    end
  end
end
