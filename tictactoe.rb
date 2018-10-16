require 'colorize'
class BoardCase
  attr_accessor :value

  def initialize(value)
    @value = value
  end
end


class Player
  attr_accessor :firstname, :type

  def initialize(firstname, type)
    @firstname = firstname
    @type = type
    puts "#{@firstname}, tu joueras avec les #{@type}"
  end
end


class Board
  attr_accessor :case_number

  def initialize
    @case_number = []
    for i in (1..9) 
      @case_number << BoardCase.new(i.to_s)
    end
    print_board
  end

  def print_board
  system 'clear'
  puts "|      |     |     |\n|  #{@case_number[0].value}   |  #{@case_number[1].value}  |  #{@case_number[2].value}  |\n|______|_____|_____|\n|      |     |     |\n|  #{@case_number[3].value}   |  #{@case_number[4].value}  |  #{@case_number[5].value}  |\n|______|_____|_____|\n|      |     |     |\n|  #{@case_number[6].value}   |  #{@case_number[7].value}  |  #{@case_number[8].value}  |\n|______|_____|_____|"
  end

  def play(choice, result)
   @case_number[choice - 1].value = result
  end

  def already_played?(choice)
    if @case_number[choice - 1].value == 'X' || @case_number[choice - 1].value == 'O'
      true
    else
      false
    end
  end

  def victory?
    win_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    victory = 0
    win_combos.each do |combo|
      if @case_number[combo[0]].value == 'X'.red && @case_number[combo[1]].value == 'X'.red && @case_number[combo[2]].value == 'X'.red
      victory = 1
      elsif @case_number[combo[0]].value == 'O'.blue && @case_number[combo[1]].value == 'O'.blue && @case_number[combo[2]].value == 'O'.blue
      victory = 2
      end
    end
    victory
  end
end


class Game
  attr_accessor :players, :board

  def initialize
    puts 'Quel est ton petit nom joueur1 ?'

    player1_name = gets.chomp
    player1 = Player.new(player1_name, 'X'.red)


    puts 'Et le tien, joueur2 ?'

    player2_name = gets.chomp
    player2 = Player.new(player2_name, 'O'.blue)

    @players = [player1, player2]
    @board = Board.new

  end

  def go
    9.times do |i|
      if @board.victory? == 0
        turn(i)
      else
        if @board.victory? == 1 
          puts "#{@players[0].firstname}, tu gagnes ! GoodGame! XxX".red
      else 
          puts "#{@players[1].firstname}, tu gagnes ! GoodGame! OoO".blue
        end
        exit
      end
    end
  end


  def turn(i)
    n = i % 2 
    puts "#{@players[n].firstname}, sur quelle case souhaites-tu jouer (entre 1 et 9) ?"
    choice = gets.chomp.to_i
      if @board.already_played?(choice) == true
        puts 'Cette case est déjà prise !'
        puts "#{@players[n].firstname}, sur quelle case souhaites-tu jouer (entre 1 et 9) ?"
        choice = gets.chomp.to_i
      end

    @board.play(choice, @players[n].type)
    @board.print_board
  end
end

Game.new.go
