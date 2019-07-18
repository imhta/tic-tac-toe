# frozen_string_literal: true

require_relative './display.module.rb'
# class is about player
class Player
  attr_accessor :name, :side
  def initialize(player_no)
    @player_no = player_no
  end

  def set_name
    Display.ask_player_name(@player_no)
    @name = gets.chomp
  end

  def self.ask_side(name)
    Display.ask_player1_side(name)
    side = gets.chomp
    Display.side_selected(name, side)
    side.upcase
  end
end
