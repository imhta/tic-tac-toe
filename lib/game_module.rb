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

module Error

def self.not_available 
  puts "Position not available, please try again with another position"
end

def self.not_valid_side
puts "This is not a valid side, please choose between X and O"
end

end

#  board class create new board when init

class Board
  attr_reader :moves, :cells, :has_no_winner
  def initialize
    @cells = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    welcome_note
    display
    @moves = 9
    @has_no_winner = true
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
      @has_no_winner = false

    end
    if (pos % 2 == 1)
      if @cells.check_diagonal? side
    puts "Game over, winner is #{side} by dia " 
      @has_no_winner = false
      end
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


end #end of board class

class Player
  attr_accessor :name, :side
  def initialize(player_no)
    @player_no = player_no
  end

  def set_name
    puts "Player #{@player_no}: what's your name? "
    @name = gets.chomp
  end
end #end of player class

board = Board.new

player1 = Player.new(1)
player2 = Player.new(2)
player1.set_name
player2.set_name



def player1.set_side
  puts "#{@name} what's your side? Choose between X and O"
  side = gets.chomp
  @side = side.upcase
  puts "Great! #{@name}, your side is #{@side}"
end

  valid_side = false 

until valid_side  

  player1.set_side
    
  if player1.side == "X" || player1.side == "O"
    valid_side = true 
  else 
    Error::not_valid_side
  end
end

player2.side = player1.side == 'X' ? 'O' : 'X'

turn = 1 

while board.moves && board.has_no_winner
  valid_move = false
  board.display

  until valid_move 
    puts "#{turn == 1? player1.name : player2.name}, choose me a position"
    pos = gets.chomp
    child_pos = (pos.to_f / 3).ceil - 1
    if (1..9).include?(pos.to_i) && board.cells[child_pos].include?(pos.to_i)
      valid_move = true
    else 
     Error::not_available
    end
    
end 


board.update(pos.to_i, turn == 1 ? player1.side: player2.side)
  


#update 
turn = turn == 1 ?  2 : 1



  # puts "#{player2.name}, choose a position"
  # pos = gets.chomp
  # board.update(pos.to_i, player2.side)


end
