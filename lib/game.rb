require_relative './board.rb'
require_relative './player.rb'
require_relative './error.module.rb'
require_relative './display.module.rb'
require 'colorize'
# frozen_string_literal: true

# class game to maintain the state of the game

class Game
    attr_accessor :board, :player1, :player2
    def initialize

            @turn= 1,
            @valid_move= false
        

        @board = Board.new
        @player1 = Player.new(1)
        @player2 = Player.new(2)
        @player1.set_name
        @player2.set_name

        def @player1.set_side

            Display.ask_player1_side(@name)
            side = gets.chomp
            @side = side.upcase
            Display.side_selected(@name, @side)
          
        end
    end



  def ask_player1_side

    until false

        @player1.set_side
    
        if @player1.side == 'X' || @player1.side == 'O'
          break
        else
          Error.not_valid_side
        end
      end
    
    end 

    def set_player2_side 
        @player2.side = @player1.side == 'X' ? 'O' : 'X'
    end

    def start
        Display.show_board @board.cells

        while !@board.moves.zero? && @board.has_no_winner
          @valid_move = false
      
          until @valid_move
            Display.ask_position(@player1.name.yellow) if @turn == 1
            Display.ask_position(@player2.name.blue) if @turn == 2
            pos = gets.chomp
            child_pos = (pos.to_f / 3).ceil - 1
            if (1..9).include?(pos.to_i) && @board.cells[child_pos].include?(pos.to_i)
              @valid_move = true
            else
              Error.not_available
            end
          end
      
          @board.update(
            pos.to_i,
            @turn == 1 ? @player1.side : @player2.side,
            @turn == 1 ? @player1.name : @player2.name
          )
      
          # update
          @turn = @turn == 1 ? 2 : 1
          Display.show_board @board.cells
        end

        Display.draw if @board.moves.zero? && @board.has_no_winner

    end 
    #end of the start method


end 
#end of the game class
