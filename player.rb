require "board.rb"

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

    puts my_symbols.inspect
    wins = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 6],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ]

    wins.each do |win|
      if (my_symbols & win).roughly_eql? win
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