# frozen_string_literal: true

require_relative './board.rb'
require_relative './player.rb'
require_relative './error.module.rb'
require_relative './display.module.rb'
require 'colorize'

# class game to maintain the state of the game
class Game
  attr_accessor :board, :player1, :player2
  def initialize
    @board = Board.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
    @player1.set_name
    @player2.set_name
  end

  def ask_player1_side
    loop do
      @player1.side = Player.ask_side @player1.name
      break if @player1.side == 'X' || @player1.side == 'O'

      Error.not_valid_side
    end
  end

  def set_player2_side
    @player2.side = @player1.side == 'X' ? 'O' : 'X'
  end

  def start
    @turn = 1
    @valid_move = false
    Display.show_board @board.cells
    game_loop
    Display.draw if @board.moves.zero? && @board.has_no_winner
  end

  private

  def check_valid_move(pos, child_pos)
    if (1..9).include?(pos) && @board.cells[child_pos].include?(pos)
      @valid_move = true
    else
      Error.not_available
    end
  end

  def ask_move
    until @valid_move
      Display.ask_position(@player1.name.yellow) if @turn == 1
      Display.ask_position(@player2.name.blue) if @turn == 2
      @pos = gets.chomp
      child_pos = (@pos.to_f / 3).ceil - 1
      check_valid_move(@pos.to_i, child_pos)
    end
  end

  def game_loop
    while !@board.moves.zero? && @board.has_no_winner
      ask_move
      @board.update(
        @pos.to_i,
        @turn == 1 ? @player1.side : @player2.side,
        @turn == 1 ? @player1.name : @player2.name
      )
      # switch the turn
      @turn = @turn == 1 ? 2 : 1
      @valid_move = false
    end
  end
end
