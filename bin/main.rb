# frozen_string_literal: true

require_relative './../lib/error.module.rb'
require_relative './../lib/display.module.rb'
require 'colorize'
require_relative './../lib/game.rb'

game_count = 0

def start_game
  game = Game.new
  game.ask_player1_side
  game.set_player2_side
  game.start
end

loop do
  if game_count.zero?
    start_game
    game_count += 1
  else
    Display.want_to_play
    res = gets.chomp
    if res.upcase == 'Y' || res.upcase == 'YES'
      start_game
    else
      Display.thank
      exit!
    end
  end
end
