class Array
  def roughly_eql? another_arr
    eql = true
    return false if another_arr.length != self.length
    self.each do |el|
      eql = false if not(another_arr.include? el)
    end
    return eql
  end
end

class Game
  attr_accessor :players

  @@winner = nil # winner of the game
  @@POSSIBLE_SHAPES = ["X", "O"]

  def self.start_game
    puts "Welcome to Tic Tac Toe:"
    puts "Please enter the name and shape for player \#1"
    print "Name: "
    name1 = gets.chomp
    while true
      print "Shape: "
      shape1 = gets.chomp.upcase
      break if @@POSSIBLE_SHAPES.index(shape1) != nil
    end
    puts "Please enter the name and shape for player \#2"
    print "Name: "
    name2 = gets.chomp
    # choose the other shape
    shape2 = @@POSSIBLE_SHAPES.find { |shape| shape != shape1 }
    @players = [Player.new(name1, shape1), Player.new(name2, shape2)]

    Board.initialize_board

    while true
      @players.each do |player|
        Game.ask_for_input player.name
        if player.check_win
          @@winner = player.name
          Game.game_over
          break
        end
      end
    end
  end

  def self.ask_for_input player_name
    player = @players.find { |player|  player.name == player_name }
    puts "#{player.name}'s turn\n"
    player.choose_cell
  end

  def self.game_over
    puts "Game Over.\nWinner is #{@@winner}"
    exit
  end
end

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

class Board
  class Cell
    attr_accessor :symbol

    def initialize symbol
      @symbol = symbol
    end
  end
  @@cells = []

  def self.initialize_board
    # populate the cells array with 9 cells with numbers from 1 to 9
    1.upto(9) do |number|
      if number % 3 == 0
        @@cells << [Cell.new(number - 2), Cell.new(number - 1), Cell.new(number)]
      end
    end
  end

  def self.print_board
    puts ""
    @@cells.each do |cells_row|
      cells_row.each_with_index do |cell, idx|
        print cell.symbol.to_s + ((idx + 1) % 3 == 0 ? "\n" : " | ")
      end
    end
    puts ""
  end

  def self.replace_cell symbol, number
    @@cells.each do |cells_row|
      cells_row.each do |cell|
        cell.symbol = symbol if cell.symbol == number
      end
    end
  end

  def self.cells
    @@cells
  end
end

Game.start_game