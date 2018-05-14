require 'byebug'

class Board
  HEIGHT = 5
  WIDTH = 5
  SIZE = HEIGHT * WIDTH
  BOMB_NUMBER = Math.sqrt(SIZE).to_i
  STATE = ['closed', 'opened', 'marked']

  attr_accessor :grid

  def initialize(height = HEIGHT, width = WIDTH)
    @grid = Array.new(HEIGHT) { Array.new(WIDTH, { state: 'closed', value: 0 }) }
    add_bombs
  end

  def reveal(y, x)
    if @grid[y][x][:state] == 'opened'
      puts 'Already revealed'
      return true
    end

    if @grid[y][x][:state] == 'marked'
      @grid[y][x] = { state: 'closed', value: @grid[y][x][:value] }
      return true
    end

    @grid[y][x] = { state: 'opened', value: @grid[y][x][:value] }
    if @grid[y][x][:value] == 'b'
      return false
    end

    if @grid[y][x][:value] == 0
      open_neighbors(y, x)
    end

    true
  end

  def win?
    @grid.each do |row|
      row.each do |cell|
        return false if cell[:state] == 'closed' && cell[:value] != 'b'
      end
    end

    true
  end

  def clicked_on_bomb?
    @grid[row][cell][:value] == 'b' && @grid[row][cell][:state] != 'marked'
  end

  private

  def add_bombs
    remaining_bombs = BOMB_NUMBER

    bomb_slots = {}

    while remaining_bombs > 0
      slot = rand(1..SIZE)
      next if bomb_slots[slot]
      bomb_slots[slot] = 1
      remaining_bombs -= 1
    end

    bomb_slots.keys.each do |num|
      row = (num - 1) / WIDTH
      col = (num - 1) % HEIGHT
      @grid[row][col] = { state: 'closed', value: 'b' }
      update_neighbors(row, col)
    end
  end

  def update_neighbors(row, col)
    -1.upto(1) do |y|
      -1.upto(1) do |x|
        next if row + y < 0 || row + y >= HEIGHT
        next if col + x < 0 || col + x >= WIDTH
        next if x == 0 && y == 0
        next if grid[row + y][col + x][:value] == 'b'
        @grid[row + y][col + x] = { 
          state: 'closed',
          value: @grid[row + y][col + x][:value] + 1
        }
      end
    end
  end

  def open_neighbors(y, x)
    visited = {}
    queue = ["#{y,x}"]

    while queue.any?
      cell = queue.shift
      cell_y = cell.split(',')[0].to_i
      cell_x = cell.split(',')[-1].to_i
      @grid[cell_y][cell_x] = { 
        state: 'opened',
        value: @grid[cell_y][cell_x][:value]
      }
      visited["#{cell_y,cell_x}"] = 1

      -1.upto(1) do |dy|
        -1.upto(1) do |dx|
          next if cell_y + dy < 0 || cell_y + dy >= HEIGHT
          next if cell_x + dx < 0 || cell_x + dx >= WIDTH
          next if dy == 0 && dx == 0
          next if visited["#{cell_y + dy},#{cell_x + dx}"]
          queue << "#{cell_y + dy},#{cell_x + dx}" if grid[cell_y + dy][cell_x + dx] == 0
        end
      end
    end
  end
end

class Player
  def initialize(board)
    @board = board
  end

  def click(y, x)
    @board.reveal(y, x)
    @board.win?
  end
end

class Game
  def initialize(height = nil, width = nil)
    @board = Board.new(height, width)
    @player = Player.new(@board)
    @wins = 0
    @losses = 0
  end

  def play
  end
end

board = Board.new
board.grid.each do |row|
  puts ""
  row.each do |cell|
    print cell[:value]
  end
end