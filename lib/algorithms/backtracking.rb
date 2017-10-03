class Backtracking
# Backtracking works best in problems where the solution is
# a sequence of choices and making a choice restrains subsequent
# choices. It identifies as soon as possible the choices you’ve
# made cannot give you the solution you want, so you can sooner
# step back and try something else.

# PROBLEM 1
# How do you place eight queens on the board such that no queens
# attack each other?
# over 4 billion possible options and 92 different solutions

  class EightQueens
    class Queen
      attr_accessor :column, :row

      def to_s
        'Q'
      end

      def location
        [column, row]
      end

      def location?(x, y)
        location == [x, y]
      end
    end

    class Board
      DEFAULT_SIZE = 8
      HORIZONTAL_EDGE = '='.freeze
      VERTICAL_EDGE = '|'.freeze
      EMPTY_FIELD = '-'.freeze

      attr_accessor :queens
      attr_reader :size

      def initialize(size: DEFAULT_SIZE)
        @size = size
        @queens = []
      end

      def rows
        size
      end

      def columns
        size
      end

      def starting_row
        0
      end

      def ending_row
        rows - 1
      end

      def starting_column
        0
      end

      def ending_column
        columns - 1
      end

      def place_queen(column = 0, row = 0)
        queen = Queen.new
        @queens << queen
        queen.column = column
        queen.row = row
        queen
      end

      def remove_queen(column, row)
        queen = find_queen(column, row)
        if queen
          queen.column = nil
          queen.row = nil
          @queens.delete(queen)
        end
      end

      def safe_position?(column, row)
        return false unless safe_column?(column)
        return false unless safe_row?(row)
        return false unless safe_diagonal?(column, row)
        true
      end

      def display
        puts
        puts HORIZONTAL_EDGE * (columns + 2)
        rows.times do |row|
          print VERTICAL_EDGE
          columns.times do |column|
            print contents_at(column, row)
          end
          puts VERTICAL_EDGE
        end
        puts HORIZONTAL_EDGE * (columns + 2)
        puts
      end

      def find_queen(column, row)
        @queens.find { |q| q.location?(column, row) }
      end

      private

      def contents_at(column, row)
        find_queen(column, row) || EMPTY_FIELD
      end

      def safe_column?(column)
        @queens.none? { |q| q.column == column }
      end

      def safe_row?(row)
        @queens.none? { |q| q.row == row }
      end

      def safe_diagonal?(column, row)
        @queens.none? { |q| (q.column - column).abs == (q.row - row).abs }
      end
    end

    @board = Board.new
    @solution_found = false

    def self.queens_with_loop
      column = 0

      while column < @board.columns
        row = 0

        last_queen = @board.queens.last
        # only runs if we are backtracking
        if last_queen && last_queen.column == column
          row = last_queen.row
          @board.remove_queen(column, row)
          row += 1

          # if no more rows in the col then col number is decreased
          # and the previous queen is removed
          if row >= @board.rows
            column -= 1
            return if column < 0
            next
          end
        end

        while row < @board.rows
          # if it is a safe position the queen is placed
          if @board.safe_position?(column, row)
            @board.place_queen(column, row)

            if column == @board.ending_column
              @solution_found = true
              return
            else
              # if it is not the last col then it increases the col number
              column += 1
              break
            end

          # if it is not a safe place
          else
            # if there is more rows in the col the row number is increased
            if row < @board.ending_row
              row += 1
            # if no more rows in col then col number is decreased
            # and the previous queen is removed
            else
              column -= 1
              return if column < 0
              break
            end
          end
        end
      end
    end

    def self.queens_with_recursion
      place_queen_in_col(0)
    end

    def self.place_queen_in_col(column)
      @board.rows.times do |row|
        if @board.safe_position?(column, row)
          @board.place_queen(column, row)

          if column == @board.ending_column
            @solution_found = true
            # for finding all solution comment out prev line and uncomment the next one
            # add_board_to_solutions(@board)
          else
            place_queen_in_col(column + 1)
          end
        end

        next if @solution_found
        @board.remove_queen(column, row)
      end
    end

    # for finding all solution
    def self.add_board_to_solutions(board)
      solution_board = Board.new
      solution_board.queens = board.queens.map(&:dup)
      @boards << solution_board
    end

    @boards = []
    queens_with_recursion
    @board.display if @solution_found
    @boards.each(&:display)
  end

  # def eight_queens_short(row= 0, cols = [0,0,0,0,0,0,0,0], results = [], default_size = 8)
  #   if row == default_size
  #     results << cols.clone
  #   else
  #     (0..default_size).each do |i|
  #       if valid?(cols, row, i)
  #         cols[row] = i
  #         eight_queens_short(row + 1, cols, results)
  #       end
  #     end
  #   end

  #   results
  # end

  # def valid?(cols, row, col)
  #   (0..row).each do |i|
  #     col2 = cols[i]

  #     return false if col == col2
  #     col_distance = (col - col2).abs
  #     row_distance = (row - i).abs

  #     return false if col_distance == row_distance
  #   end

  #   true
  # end

  p new.eight_queens_short
end
