# frozen_string_literal: true

#  board class create new board when init
#
class Board
  def initialize
    @cells = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    create_board
  end

  def create_board
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
end

class Player
end

new_board = Board.new