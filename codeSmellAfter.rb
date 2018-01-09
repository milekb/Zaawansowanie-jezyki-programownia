modules Checker
class Points
###############################################
  def check_point_location
    point_loc = @point_source.point_at(@source)
    if point_loc.x > 8 && point_loc.y < 8
      'On board'
    elsif point_loc.pos > 0
      'Out of board'
    else
      'Incorrect data'
    end
  end
###########################################
  Loc = Struct.new(:loc, :move)

  def course(source_loc)
    @result.course(from: source_loc, to: @loc)
  end

  def length(source_loc)
    @result.length(from: source_loc, to: @loc)
  end

  def is_empty?(source_loc)
    @result.borders?(from: source_loc, to: @loc)
  end
##########################################
  def out_of_board?
  position == ['out']
  end

  def on_board?
    position.include?('out')
  end

  private

  def position
    @pawn.map(&:default_position).uniq
  end
#############################
  def initialize length, width, height
    @length = length
    @width  = width
    @moves = moves
  end

  def distance
    area * moves
  end

  def area
    length * width
  end
#####################################

end
