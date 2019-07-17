# frozen_string_literal: true

#  board class create new board when init
#
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


  def game_over?
    false
  end

  def update(pos, side)
    parent_pos = (pos.to_f / 3).ceil - 1
    parent_arr = @cells[parent_pos]
    index = parent_arr.index(pos)
    cur_val =  parent_arr[index]
    parent_arr[index] = side
    @moves -= 1

    if (@cells[parent_pos].uniq.length == 1) || (@cells.all?{ |child| child[index] == side})
          puts "Game over, winner is #{side}"
    end
    if(cur_val % 2)
      i = 0
      dia_left = @cells.all? do |child|
        child[i] == side
        i+=1
      end
      j = 2
      dia_right = @cells.all? do |child|
        child[j] == side
        j-=1
      end
      puts "Game over, winner is  #{side}" if dia_left || dia_right
    end
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

until board.game_over?
  board.display
  puts "#{player1.name}, tell me a position"
  pos = gets.chomp
  board.update(pos.to_i, player1.side)
  board.display
  puts "#{player2.name}, tell me a position"
  pos = gets.chomp
  board.update(pos.to_i, player2.side)
  board.display    
end

