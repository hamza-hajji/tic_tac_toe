class Board
  Cell = Struct.new :symbol
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
