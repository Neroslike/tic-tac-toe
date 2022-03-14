# Player class
class Player
  attr_accessor :name, :turn

  def initialize(name)
    @name = name
  end

  def play(index, value, board_object)
    board_object.change_board(index, value)
  end
end

# Board Class
class Board
  attr_accessor :player1, :player2

  @@game_board = Array.new(9, 'X')

  def board
    @game = "#{@@game_board[0]} | #{@@game_board[1]} | #{@@game_board[2]}
----------
#{@@game_board[3]} | #{@@game_board[4]} | #{@@game_board[5]}
----------
#{@@game_board[6]} | #{@@game_board[7]} | #{@@game_board[8]}"
  end

  def change_board(index, value)
    @@game_board[index] = value
  end

  def start_game
    puts 'Insert player 1 name'
    @player1 = Player.new(gets.chomp)
    puts 'Insert player 2 name'
    @player2 = Player.new(gets.chomp)
    puts "#{player1.name} are O's and #{player2.name} are X's"
    player1.turn = true
    puts '####################################'
  end

  def game(player)
    puts '####################################'
    puts board
    puts "#{player.name}'s turn"
    puts 'Insert the position you want to place your play'
    play = gets.chomp
    player.play(play.to_i - 1, 'O', self)
    puts self.board
  end

  def test(culo)
    puts culo
  end
end

board = Board.new
board.start_game
loop do
  board.game(board.player1)
  board.game(board.player2)
end
