class Board
  WIDTH = 3
  HEIGHT = WIDTH

  attr_accessor :grid

  def initialize
    @grid = Array.new(HEIGHT) { Array.new(WIDTH, '-') }
  end

  def display
    output = "\n"
    output << generate_table.join
    output << "\n"
    puts output
  end

  def [](y, x)
    @grid[y][x]
  end

  def []=(y, x)
    @grid[y][x]
  end

  # def win?
  #   row_win? ||
  #   column_win? ||
  #   diagonal_win?
  # end

  def full?
    @grid.each do |row|
      row.each do |cell|
        return false if cell == '-'
      end
    end

    true
  end

  private

  def generate_table
    row_length = @grid[0].length
    table = []

    @grid.each_with_index do |row, i|
      table_row = []
      row.each_with_index do |cell, j|
        table_row << cell
        table_row << '|' unless row_length - 1 == j
      end
      table_row << "\n"
      table << table_row
    end

    table
  end
end

class AI
  def initialize
    @board = Board.new
  end

  def make_move
    y = 0
    x = 0

    while @board.grid[y][x] != '-'
      puts @board.grid[y][x]
      puts y
      puts x
      if y < Board::WIDTH - 1
        y += 1
        next
      end

      if x < Board::HEIGHT - 1
        x += 1
        y = 0
        next
      end

      raise 'Full grid'
    end
    @board.grid[y][x] = 'X'
    @board.grid.display
  end
end

# board = Board.new
# board.display
# board.grid[1][1] = 'X'
# board.display
# p board.full?
ai = AI.new
ai.make_move
ai.make_move
ai.make_move
ai.make_move
ai.make_move
ai.make_move
ai.make_move
ai.make_move
ai.make_move
ai.make_move
