# frozen_string_literal: true

# Global Variables
$rounds = [
  [0, 0, 0], [0, 0, 0],
  [0, 0, 0], [0, 0, 0],
  [0, 0, 0], [0, 0, 0],
  [0, 0, 0], [0, 0, 0],
  [0, 0, 0], [0, 0, 0, 0]
]
$score = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
$contador = 1

# CLASE DE BOWLING
class ScoreBoard
  def draw
    (0..$contador - 2).each do |round|
      puts "\nRound #{round + 1} \n"
      (0..($rounds[round].length - 1)).each do |num|
        print_rounds(round, num)
      end
      puts
    end
    last
  end

  def print_rounds(round, num)
    puts if num == $rounds[round].length - 1
    num_zero = num.zero? && $rounds[round][num] == 10
    num_one = num == 1 && $rounds[round][num] == 10
    validate_print([num_zero, num_one, num_zero == false && num_one == false], round, num)
  end

  def validate_print(number, round, num)
    print('X ') if number[0]
    print('/ ') if number[1]
    print("#{$rounds[round][num]} ") if number[2]
  end

  def last
    puts "\nRound 10 \n"
    if $rounds[9][1] == 10 || $rounds[9][0] == 10
      print_last(2)
    else
      print_last(1)
    end
    print_rounds(9, 3)
    puts
  end

  def print_last(fin)
    (0..fin).each do |num|
      print_rounds(9, num)
    end
  end

  def jump
    puts if num == $rounds[round].length - 1
  end

  def score(round)
    $score[round] = if $rounds[round][1] == 10
                      10
                    else
                      $rounds[round][0] + $rounds[round][1]
                    end
  end

  def last_score
    if $rounds[9][1] == 10
      (1..2).each do |num|
        $score[9] += $rounds[9][num]
      end
    else
      (0..2).each do |num|
        $score[9] += $rounds[9][num]
      end
    end
  end

  def final_score
    (0..$contador - 2).each do |round|
      strike(round) if $rounds[round][0] == 10
      spare(round) if $rounds[round][1] == 10
    end
    $rounds[9][$rounds[9].length - 1] = $score[9]
    suma
  end

  def strike(round)
    $score[round] += $score[round + 1]
  end

  def spare(round)
    $score[round] += $rounds[round + 1][0]
  end

  def suma
    (0..$contador - 1).each do |round|
      $score[round] += $score[round - 1] if round >= 1
      $rounds[round][$rounds[round].length - 1] = $score[round]
    end
  end
end

# Class Player
class Player
  def initialize
    @scoreboard = ScoreBoard.new
  end

  def strikes(init)
    (init..$contador).each do |round|
      score = 10
      (0..1).each do |num|
        strike = rand(0..score)
        $rounds[round][num] = strike
        score -= strike
      end
      validate(round)
    end
  end

  def validate(round)
    $rounds[round][1] = 10 if $rounds[round][0] + $rounds[round][1] == 10 && $rounds[round][0] != 10
    @scoreboard.score(round) if round != 9
  end

  def last_strike
    if $rounds[9][0] == 10
      strike = rand(0..10)
      (1..2).each do |num|
        strike = rand(0..10)
        $rounds[9][num] = strike
      end
    elsif $rounds[9][1] == 10
      strike = rand(0..10)
      $rounds[9][2] = strike
    end
  end
end

scoreboard = ScoreBoard.new
player = Player.new

init = 0
while $contador <= 9
  player.strikes(init)
  $contador += 1
  init += 1
end
player.last_strike
scoreboard.last_score
scoreboard.final_score
scoreboard.draw
