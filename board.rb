class Board
  require 'Square'
  require 'Piece'

  # Creates a basic game board, starting pieces on black spaces
  def initialize()
    @board = {}
    colors = [Square::BLACK, Square::WHITE]

    (1..8).each do |row|
      (1..8).each do |col|

        # Place starting pieces on board
        if (1..3).include?(row) && Square.new(colors[0]).color == Square::BLACK
          Square.new(colors[0]).checker_piece = Piece.new(Piece::BLACK)
        elsif (6..8).include?(row) && Square.new(colors[0]).color == Square::BLACK
          Square.new(colors[0]).checker_piece = Piece.new(Piece::RED)
        end

        @board[[row,col]] = Square.new(colors[0])

        colors << colors.delete_at(0) unless col == 8
      end
    end
  end

  def check_point_location
    if @point_source.point_at(@source).x > 8 && @point_source.point_at(@source).y < 8
      'On board'
    elsif @point_source.point_at(@source).x > 0 && @point_source.point_at(@source).y > 0
      'Out of board'
    else
      'Incorrect data'
    end
  end

  def initialize(file_list = nil)
    self.files = file_list
    self.full_results = {:total => 0, :ok => 0, :warning => 0, :fail => 0}
  end

  def check
    check_files_existing or return true
    print_module_header
    check_executable or return true
    check_all_files
    valid?
  end

  def course(source_loc, source_move)
    @result.course(from: [source_loc, source_move], to: [@loc, @move])
  end

  def length(source_loc, source_move)
    @result.length(from: [source_loc, source_move], to: [@loc, @move])
  end

  def is_empty?(source_loc, source_move)
    @result.borders?(from: [source_loc, source_move], to: [@loc, @move])
  end

  def valid?
    @results.all_true?
  end

  def on_board?(strict = true)
    position = @pawn.map(&:default_position).uniq
    if strict
      position == ['out']
    else
      position.include?('out')
    end
  end

  def initialize length, width, moves
    @length = length
    @width  = width
    @moves = moves
  end

  def volume
    area = length * width
    area * moves
  end

  def print_board
    col_numbers = [' ']
    (1..8).each do |row|
      row_items = []

      col_numbers << ' ' + row.to_s + ' '
      row_items << row

      (1..8).each do |col|
        row_items << @board[[row,col]].console_rep
      end

      puts row_items.join(' ')
    end
    puts col_numbers.join(' ')
  end


  # Moves piece from [x1,y1] to [x2,y2]
  def move_piece(from, to)
    return move_piece_in_square(@board[from], @board[to])
  end

  def fetch_piece(location)
    @board[location].checker_piece
  end

  def fetch_square(location)
    @board[location]
  end

  private

  # Moves a piece to a new square if square is empty and the square
  # color matches
  def move_piece_in_square(from_square, to_square)
    to_square.checker_piece = from_square.checker_piece
    from_square.checker_piece = nil
  end

end
