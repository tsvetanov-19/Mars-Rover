# frozen_string_literal: true

require_relative './move'
require_relative './board'
require_relative './rotation'
require_relative '../config/constants'

class Commander
  include Constants
  include Rotation
  include Move

  attr_accessor :commands
  def allowed
    %w[L R M]
  end

  def initialize(list, obstacles = true)
    @commands = []
    command_list = list.split('')
    command_list.each(&method(:verify_commands))
    @current_point = Point.new(START_X, START_Y)
    @current_direction = Direction.new(START_DIRECTION)
    @board = Board.new(obstacles)
    @stuck = false
  end

  def run
    @current_direction = Direction.new(START_DIRECTION)

    @commands.each do |c|
      @stuck = true if @board.obstacle?(@current_point)
      break if @stuck

      if c == 'M'
        @current_point = step_forward(@current_point, @current_direction)
      else
        @current_direction = rotate(@current_direction, c)
      end

    end
    rest
  end

  def rest
    finish = ''
    finish += 'O,' if @stuck
    finish + "#{@current_point.x_coord},#{@current_point.y_coord},#{translate_direction(@current_direction.direction)}"
  end


  private

  def verify_commands(command)
    unless allowed.include? command
      raise StandardError, "Unknown command #{command} !"
    end

    @commands.push(command)
  end

  def translate_direction(dir)
    case dir
    when 'north'
      'N'
    when 'south'
      'S'
    when 'west'
      'W'
    else
      'E'
    end
  end

end