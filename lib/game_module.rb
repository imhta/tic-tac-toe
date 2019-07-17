# frozen_string_literal: true


module Enumerable
  def check_diagonal?(side)
    i = -1
    j = 3
    dia_left = self.all? do |child|
      i += 1
      child[i] == side
    end
    dia_right = self.all? do |child|
      j -= 1
      child[j] == side
    end
    dia_left || dia_right
  end
end

#  board class create new board when init

class Board
  attr_reader :moves
  def initialize
    @cells = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    welcome_note
    display
    @moves = 9
  end

  private

  def welcome_note
    puts "Welcome to the tic-tac-toe game! .
  1. The game is played on a grid that's 3 squares by 3 squares.
  2. You are X or O, your friend is O or X. Players take turns putting their marks in empty squares.
  3. The first player to get 3 in a row (up, down, across, or diagonally) is the winner.
  4. When all 9 squares are full, the game is over. If no player has 3."
  end

  public

  def display
    puts '---+---+---'
    @cells.each do |i|
      line = ''
      i.each_with_index do |v, j|
        line += " #{v} |" if j != 2
        line += " #{v} " if j == 2
      end
      puts line
      puts '---+---+---'
    end
  end

  def game_over?(parent_pos, child_pos, side, pos)
    if (@cells[parent_pos].uniq.length == 1) || (@cells.all? { |child| child[child_pos] == side })
      puts "Game over, winner is #{side}"
    end
    if (pos % 2 == 1)
      puts "Game over, winner is #{side} by dia" if @cells.check_diagonal? side
    end
  end

  def update(pos, side)
    parent_pos = (pos.to_f / 3).ceil - 1
    parent_arr = @cells[parent_pos]
    child_pos = parent_arr.index(pos)
    parent_arr[child_pos] = side
    @moves -= 1
    game_over?(parent_pos, child_pos, side, pos) if @moves <= 5
  end
end

class Player
  attr_accessor :name, :side
  def initialize(player_no)
    @player_no = player_no
  end

  def set_name
    puts "Player #{@player_no}: what's your name? "
    @name = gets.chomp
  end
end

board = Board.new

player1 = Player.new(1)
player2 = Player.new(2)
player1.set_name
player2.set_name

def player1.set_side
  puts "#{@name} what's your side? Choose between X and O"
  side = gets.chomp
  @side = side.upcase
end

player1.set_side
player2.side = player1.side == 'X' ? 'O' : 'X'

while board.moves
  board.display

  puts "#{player1.name}, tell me a position"
  pos = gets.chomp
  board.update(pos.to_i, player1.side)

  board.display

  puts "#{player2.name}, tell me a position"
  pos = gets.chomp
  board.update(pos.to_i, player2.side)
end
