modules Checker
class Points
  ############################################
  def initialize()
    @board = {}
    colors = [Square::BLACK, Square::WHITE]

    (1..8).each do |row|
      (1..8).each do |col|
        sq = Square.new(colors[0])
        # Place starting pieces on board
        if (1..3).include?(row) && sq.color == Square::BLACK
          sq.checker_piece = Piece.new(Piece::BLACK)
        elsif (6..8).include?(row) && sq.color == Square::BLACK
          sq.checker_piece = Piece.new(Piece::RED)
        end

        @board[[row,col]] = sq

        colors << colors.delete_at(0) unless col == 8
      end
    end
  end
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
