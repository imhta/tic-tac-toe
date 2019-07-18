require 'colorize'
require_relative './error.module.rb'
require_relative './display.module.rb'
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

#  board class create new board when init
class Board
    attr_reader :moves, :cells, :has_no_winner
    def initialize
      @cells = [[1, 2, 3],
                [4, 5, 6],
                [7, 8, 9]]
      @moves = 9
      @has_no_winner = true
      Display.welcome_note
      display
    end
  
    def display
      puts ""  
      puts '---+---+---'.blue
      @cells.each do |i|
        line = ''
        i.each_with_index do |v, j|
          line += " #{v} #{'|'.blue}" if j != 2
          line += " #{v} " if j == 2
        end
        puts line
        puts '---+---+---'.blue
      end
      puts ""
    end
  
    private
  
    def game_over?(parent_pos, child_pos, side, _pos, name)
      if @cells[parent_pos].uniq.length == 1 ||
         @cells.all? { |child| child[child_pos] == side } ||
         @cells.check_diagonal?(side)
  
        Display.celebrate_winner name
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
  
  