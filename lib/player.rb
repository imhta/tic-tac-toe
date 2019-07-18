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
  end
  