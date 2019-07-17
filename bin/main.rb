# frozen_string_literal: true

require_relative './../lib/game_module'

game_count = 0

def game
  board = Board.new

  player1 = Player.new(1)
  player2 = Player.new(2)
  player1.set_name
  player2.set_name

  def player1.set_side
    GameMessages.ask_player1_side(@name)
    side = gets.chomp
    @side = side.upcase
    GameMessages.side_selected(@name, @side)
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

  while board.moves && board.has_no_winner
    valid_move = false
    board.display

    until valid_move
      GameMessages.ask_position(player1.name) if turn == 1
      GameMessages.ask_position(player2.name) if turn == 2
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

  end
  GameMessages.draw if board.moves.zero? && board.has_no_winner
end

loop do
  if game_count.zero?
    game
    game_count += 1
  else
    GameMessages.want_to_play
    res = gets.chomp
    if res.upcase == 'Y' || res.upcase == 'YES'
      game
    else
      GameMessages.thank
      exit!
    end
  end
end
