# frozen_string_literal: true

# class for error messages
module Error
  def self.not_available
    puts 'Position not available, please try again with another position'.red
  end

  def self.not_valid_side
    puts 'This is not a valid side, please choose between X and O'.red
  end
end
