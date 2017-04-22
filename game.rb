require "./board.rb"
require "./player.rb"

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
      if Game.draw?
        puts "Game Over\nDRAW!"
        break
      end
    end
  end

  def self.draw?
    draw = true
    Board.cells.flatten.each do |cell|
      draw = false if (1..9).to_a.include? cell.symbol
    end
    return draw
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