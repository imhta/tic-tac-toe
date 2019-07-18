# frozen_string_literal: true

# this class has game messages
module Display
  def self.welcome_note
    puts " Welcome to the tic-tac-toe game!.
  1. The game is played on a grid that's 3 squares by 3 squares.
  2. You are X or O, your friend is O or X.
  3. Players take turns putting their marks in empty squares.
  4. The first player to get 3 in a row wins.
  5. When all 9 squares are full, the game is over. If no player has 3.".green
  end

  def self.show_board(cells)
    puts ''
    puts '---+---+---'.blue
    cells.each do |i|
      line = ''
      i.each_with_index do |v, j|
        line += " #{v} #{'|'.blue}" if j != 2
        line += " #{v} " if j == 2
      end
      puts line
      puts '---+---+---'.blue
    end
    puts ''
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
