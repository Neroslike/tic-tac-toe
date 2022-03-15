require 'pry-byebug'

# Methods to check conditionals
module Assist
  def numeric?(char)
    char.match?(/[[:digit:]]/)
  end

  def check_array(arr, arr2)
    checks = []
    arr.each do |element|
      element.each do |value|
        if arr2.include?(value)
          checks.push(true)
        else
          checks.push(false)
        end
        if checks.length == 3 && checks.all? {|i| i == true}
          return true
        elsif checks.length == 3 && checks.any? {|i| i == false}
          checks.clear
        end
      end
    end
  end
end

######################################### Player class #########################################
class Player
  attr_accessor :name, :symbol, :pos

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @pos = []
  end

  # Puts the player symbol in the board
  def play(index, value, board_object)
    board_object.change_board(index, value)
  end

  def set_position(position)
    @pos.push(position)
  end
end

######################################### Board Class #########################################
class Board
  include Assist

  attr_accessor :player1, :player2, :game_done

  # @@game_board = Array.new(9, ' ')
  @@game_board = [*1..9]
  WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [3, 5, 7], [1, 5, 9]]
  def board
    @game = "#{@@game_board[0]} | #{@@game_board[1]} | #{@@game_board[2]}
----------
#{@@game_board[3]} | #{@@game_board[4]} | #{@@game_board[5]}
----------
#{@@game_board[6]} | #{@@game_board[7]} | #{@@game_board[8]}"
  end

  def restart
    for i in 0..8 do
      @@game_board[i] = i + 1
    end
  end

  def initialize
    @game_done = false
  end

  # Change a symbol in the board
  def change_board(index, value)
    if @@game_board[index] != 'X' && @@game_board[index] != 'O'
      @@game_board[index] = value
    else
      false
    end
  end

  # Starts a new game, initializes new players if a previous game was played
  def start_game
    @game_done = false
    puts 'Insert player 1 name'
    @player1 = Player.new(gets.chomp, 'O')
    puts 'Insert player 2 name'
    @player2 = Player.new(gets.chomp, 'X')
    puts "#{player1.name} are O's and #{player2.name} are X's"
  end

  def game(player)
    play = 0
    puts "####################################\n#{board}\n####################################"
    puts "#{player.name}'s turn"
    puts 'Insert the position you want to place your play'
    loop do
      play = gets.chomp
      if numeric?(play) && player.play(play.to_i - 1, player.symbol, self) != false
        player.play(play.to_i - 1, player.symbol, self)
        player.set_position(play.to_i)
        check_positions(player)
        break
      else
        puts 'Please input a number and check the position is not already taken'
      end
    end
    check_win(player)
  end

  def check_positions(player)
    puts "#{player.name} positions are: #{player.pos}"
  end

  def check_win(player)
    if check_array(WINNING_COMBINATIONS, player.pos) == true
      puts "#{player.name} has won the game!"
      @game_done = true
    elsif @@game_board.all? {|element| element.is_a? String}
      puts "Draw! All positions taken"
      @game_done = true
    end
  end
end

board = Board.new
loop do
  board.start_game
  loop do
    board.game(board.player1)
    if board.game_done == true
      board.restart
      break
    end
    board.game(board.player2)
    if board.game_done == true
      board.restart
      break
    end
  end
end
