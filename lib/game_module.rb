require 'colorize'
# frozen_string_literal: true

# added a method to enumerable
module Enumerable
  # check_diagonal used to check diagonally all are same or not
  def check_diagonal?(side)
    i = -1
    j = 3
    dia_left = all? do |child|
      i += 1
      child[i] == side
    end
    dia_right = all? do |child|
      j -= 1
      child[j] == side
    end
    dia_left || dia_right
  end
end

# class for error messages
module Error
  def self.not_available
    puts 'Position not available, please try again with another position'.red
  end

  def self.not_valid_side
    puts 'This is not a valid side, please choose between X and O'.red
  end
end

# this class has game messages
module GameMessages
  def self.welcome_note
    puts " Welcome to the tic-tac-toe game!.
  1. The game is played on a grid that's 3 squares by 3 squares.
  2. You are X or O, your friend is O or X.
  3. Players take turns putting their marks in empty squares.
  4. The first player to get 3 in a row wins.
  5. When all 9 squares are full, the game is over. If no player has 3.".green
  end

  def self.celebrate_winner(name)
    puts "Game over, winner is #{name}".green
  end

  def self.draw
    puts 'It is draw wanna try again?'.green
  end

  def self.ask_player_name(player_no)
    puts "Player #{player_no}: what's your name? "
  end

  def self.ask_player1_side(player_name)
    puts "#{player_name} What's your side? Choose between X and O"
  end

  def self.side_selected(player_name, side)
    puts "Great! #{player_name}, your side is #{side}"
  end

  def self.ask_position(player_name)
    puts "#{player_name}, choose me a position"
  end

  def self.want_to_play
    puts 'Want to play another game? Y or N'
  end

  def self.thank
    puts 'Thank you for playing!, see you :)'
  end
end

#  board class create new board when init
class Board
  attr_reader :moves, :cells, :has_no_winner
  def initialize
    @cells = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @moves = 9
    @has_no_winner = true
    GameMessages.welcome_note
    display
  end

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

  private

  def game_over?(parent_pos, child_pos, side, _pos, name)
    if @cells[parent_pos].uniq.length == 1 ||
       @cells.all? { |child| child[child_pos] == side } ||
       @cells.check_diagonal?(side)

      GameMessages.celebrate_winner name
      @has_no_winner = false
    end
  end

  public

  def update(pos, side, name)
    parent_pos = (pos.to_f / 3).ceil - 1
    parent_arr = @cells[parent_pos]
    child_pos = parent_arr.index(pos)
    parent_arr[child_pos] = side
    @moves -= 1
    game_over?(parent_pos, child_pos, side, pos, name) if @moves <= 5
  end
end

# class is about player
class Player
  attr_accessor :name, :side
  def initialize(player_no)
    @player_no = player_no
  end

  def set_name
    GameMessages.ask_player_name(@player_no)
    @name = gets.chomp
  end
end
