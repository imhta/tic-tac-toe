# frozen_string_literal: true

#  board class create new board when init
#
class Board
  def initialize
    @cells = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    welcome_note
    create_board
  end
    private 
  def create_board
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

  def welcome_note
    puts"Welcome to the tic-tac-toe game! .
  1. The game is played on a grid that's 3 squares by 3 squares.
  2. You are X or O, your friend is O or X. Players take turns putting their marks in empty squares.
  3. The first player to get 3 in a row (up, down, across, or diagonally) is the winner.
  4. When all 9 squares are full, the game is over. If no player has 3."
  end
end

class Player
  attr_accessor :name, :side
  def initialize(player_no)
  @player_no = player_no
  end

  def get_name
  puts "Player #{@player_no}: what's your name? "
  @name = gets.chomp
  end


end

board = Board.new 

player_1 = Player.new(1)
player_2 = Player.new(2)
player_1.get_name
player_2.get_name

def player_1.set_side
  puts "#{@name} what's your side? Choose between X and O"
  @side = gets.chomp
end
player_1.set_side
player_2.side = player_1.side == "X" ? "O" : "X"



