class Menu

  def welcome
    puts "Welcome to Tic Tac Toe".center(60, "=")
    sleep 1
    main
  end

  def main
    puts "1. Play"
    puts "2. Show Rules"
    puts "3. Exit"
    print "> "
    option = gets.chomp

    case option
      when"1"
        TicTacToe.new.play

      when "2"
        display_rules
        main

      when"3"
        exit(0)
    end
  end

  def display_rules

    puts """
  The object of Tic Tac Toe is to get three in a row.
You play on a three by three game board. The first
player is known as X and the second is O.
  Players alternate placing Xs and Os on the game
board until either oppent has three in a row or all
nine squares are filled.

"""
    puts "Table and positions:"
    puts " 1 | 2 | 3 "
    puts  "-----------"
    puts " 4 | 5 | 6 "
    puts "-----------"
    puts  " 7 | 8 | 9 "

    puts "=" * 60
  end

end



class TicTacToe

  def initialize
    @board = [" "," "," "," "," "," "," "," "," ",]
  end

  WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # last row
  [0,3,6], # first column
  [1,4,7], # midle column
  [2,5,8], # last column
  [0,4,8], # diagonal 1
  [2,4,6] # diagonal 2
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player="X")
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index] == " " || @board[index] == "" || @board[index] == nil)
  end

  def valid_move?(index)
    position_taken?(index) == false && index.between?(0,8) == true
  end


  def turn_count
    board_position = 0
    @board.each do |position|
      if position == "X" || position == "O"
        board_position += 1
      end
    end
    board_position
  end

  def current_player
    if turn_count % 2 == 0
      "X"
    else
      "O"
    end
  end

  def turn
    puts "Please enter 1-9: | Or E to exit the game."
    user_input = gets.chomp
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    elsif user_input.downcase == "e"
      exit(0)
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
    end
    false
  end

  def full?
    @board.none? {|i| i == " "}
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw? || full?
  end

  def winner
    winning_index = won?
    if winning_index
      @board[winning_index[0]]
    end
  end

  def play
    display_board
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "It's a draw!"
    end
  end

end

Menu.new.welcome
