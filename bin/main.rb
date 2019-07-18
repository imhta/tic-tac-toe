# frozen_string_literal: true

require_relative './../lib/board.rb'
require_relative './../lib/player.rb'
require_relative './../lib/error.module.rb'
require_relative './../lib/display.module.rb'
require 'colorize'
game_count = 0

def game
  board = Board.new

  player1 = Player.new(1)
  player2 = Player.new(2)
  player1.set_name
  player2.set_name

  def player1.set_side
    Display.ask_player1_side(@name)
    side = gets.chomp
    @side = side.upcase
    Display.side_selected(@name, @side)
  end

  valid_side = false

  until valid_side

    player1.set_side

    if player1.side == 'X' || player1.side == 'O'
      valid_side = true
    else
      Error.not_valid_side
    end
  end

  player2.side = player1.side == 'X' ? 'O' : 'X'

  turn = 1
  board.display
  while !board.moves.zero? && board.has_no_winner
    valid_move = false

    until valid_move
      Display.ask_position(player1.name.yellow) if turn == 1
      Display.ask_position(player2.name.blue) if turn == 2
      pos = gets.chomp
      child_pos = (pos.to_f / 3).ceil - 1
      if (1..9).include?(pos.to_i) && board.cells[child_pos].include?(pos.to_i)
        valid_move = true
      else
        Error.not_available
      end
    end

    board.update(
      pos.to_i,
      turn == 1 ? player1.side : player2.side,
      turn == 1 ? player1.name : player2.name
    )

    # update
    turn = turn == 1 ? 2 : 1
    board.display
  end

  Display.draw if board.moves.zero? && board.has_no_winner
end

loop do
  if game_count.zero?
    game
    game_count += 1
  else
    Display.want_to_play
    res = gets.chomp
    if res.upcase == 'Y' || res.upcase == 'YES'
      game
    else
      Display.thank
      exit!
    end
  end
end
