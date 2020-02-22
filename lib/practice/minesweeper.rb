require 'byebug'
require 'colorize'

class Minesweeper
  module Status
    WIN = 'win'
    PLAY = 'play'
    LOSS = 'loss'
  end

  def initialize(size_x = 10, size_y = 10, bombs = 10)
    @board = Board.new(size_x, size_y, bombs)
    @game = Game.new(@board)
    @game.play
  end

  def print_board
    @board.print_board
  end

  class Game
    attr_reader :status
    def initialize(board)
      @status = Status::PLAY
      @board = board
    end

    def play
      while @status == Status::PLAY
        row, col = get_input
        step_result = @board.step(row, col)
        update_to_loss if step_result == Status::LOSS
        update_to_win if step_result == Status::WIN
      end
      @board.print_board
      p 'YOU WON' if @status == Status::WIN
      p 'YOU LOOSE' if @status == Status::LOSS
    end

    private

    def get_input
      @board.print_board
      puts "Choose a field like: 1,1"
      input = gets.chomp
      formatted_input = input.split(',')
      row_val = @board.board_length - formatted_input[0].to_i
      col_val = formatted_input[1].to_i - 1
      [row_val, col_val]
    end

    def update_to_win
      @status = Status::WIN
    end

    def update_to_loss
      @status = Status::LOSS
    end
  end

  class Board
    attr_reader :board

    def initialize(x = 10, y = 10, bombs = 10)
      @x = x
      @y = y
      @bombs = bombs
      build
    end

    def step(row, col)
      if board[row][col][:value] == 'X'
        board.each do |row|
          row.each do |cell|
            cell[:hidden] = false
          end
        end
        return Status::LOSS
      else
        if board[row][col][:value] == 0
          open_fields(row, col)
        else
          board[row][col][:hidden] = false
        end
        return Status::WIN if win?
      end
      Status::PLAY
    end

    def win?
      hidden_cells = 0
      board.each do |row|
        row.each do |cell|
          hidden_cells += 1 if cell[:hidden]
        end
      end
      @bombs == hidden_cells
    end

    def board_length
      board.length
    end

    def print_board
      printed_board = layout
      board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          if cell[:hidden]
            printed_board[i * 2 + 1] << " #{cell[:value].to_s.colorize(:background => :white)} |"
          else
            printed_board[i * 2 + 1] << " #{cell[:value].to_s} |"
          end
        end
      end
      puts printed_board
    end

    private

    def build
      @board = Array.new(@x) { Array.new(@y) { { value: 0, hidden: true } } }
      place_bombs
      update_numbers
    end

    def place_bombs
      bombs_left = @bombs
      while bombs_left > 0
        cell = @board.sample.sample
        next if cell[:value] == 'X' 

        cell[:value] = 'X'
        bombs_left -= 1
      end
    end

    def update_numbers
      @board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          next unless cell[:value] == 'X'

          (-1).upto(1) do |k|
            (-1).upto(1) do |l|
              if i + k >= 0 && i + k < @board.length && j + l >= 0 && j + l < row.length
                next if @board[i + k][j + l][:value] == 'X'
                @board[i + k][j + l][:value] += 1
              end
            end
          end
        end
      end
    end
    
    def open_fields(row, col)
      fields_to_open = [[row, col]]

      while fields_to_open.any?
        open_field = fields_to_open.shift
        i = open_field[0]
        j = open_field[1]

        (-1).upto(1) do |k|
          (-1).upto(1) do |l|
            if i + k >= 0 && i + k < @board.length && j + l >= 0 && j + l <  @board.first.length
              next if board[i + k][j + l][:hidden] == false
              board[i + k][j + l][:hidden] = false
              fields_to_open.push([i + k, j + l]) if @board[i + k][j + l][:value] == 0
            end
          end
        end
      end
    end

    def layout
      [
        "   | ―-------------------------------------",
        "10 |",
        "   | ―-------------------------------------",
        " 9 |",
        "   | ―-------------------------------------",
        " 8 |",
        "   | ―-------------------------------------",
        " 7 |",
        "   | ―-------------------------------------",
        " 6 |",
        "   | ―-------------------------------------",
        " 5 |",
        "   | ―-------------------------------------",
        " 4 |",
        "   | ―-------------------------------------",
        " 3 |",
        "   | ―-------------------------------------",
        " 2 |",
        "   | ―-------------------------------------",
        " 1 |",
        "   + ―-------------------------------------",
        "     1   2   3   4   5   6   7   8   9   10"
      ]
    end
  end
end

minesweeper = Minesweeper.new
