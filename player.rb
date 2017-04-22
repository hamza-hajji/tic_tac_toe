require "./board.rb"
require "./array_helper"

class Player
  attr_accessor :name, :shape

  def initialize name, shape
    @name = name
    @shape = shape
    puts "Player #{name} has a shape of #{shape}\n"
  end

  def check_win
    won = false
    my_symbols = []
    Board.cells.flatten.each_with_index do |cell, idx|
      my_symbols << idx + 1 if @shape == cell.symbol
    end
    wins = [
      [1, 2, 3], # Horizontal
      [4, 5, 6], # 
      [7, 8, 9], #
      [1, 4, 7], # Vertical
      [4, 5, 6], # 
      [3, 6, 9], # 
      [1, 5, 9], # Diagonal
      [3, 5, 7]  #  
    ]

    wins.each do |win|
      if win.roughly_eql? (my_symbols & win)
        won = true
      end
    end

    return won
  end

  def choose_cell
    Board.print_board
    print "Choose a cell number: "
    puts ""
    while true
      print "Number: "
      number = gets.chomp.to_i
      break if (1..9).include? number
    end
    symbol = @shape
    # populate the board with player's shape
    Board.replace_cell symbol, number

    Board.print_board
  end
end