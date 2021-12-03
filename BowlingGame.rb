#CLASE DE BOWLING
class BowlingGame
  def initialize
      @Rounds = [[1, 4, 5], [4, 5, 14], [10, 0, 29 ], [0, 10, 49], [0, 0, 60], [0, 1, 61], [7, 0, 77], [6, 0, 97], [0, 0, 117], [2, 0, 6, 133]]
  end
  
  def draw
    rounds = 10
    (0..rounds-1).each do |round|
      puts "\nRound #{round + 1} \n"
      (0..(@Rounds[round].length) - 1).each do |num|
        next if round == 9 && num == 2 && @Rounds[round][num - 1] + @Rounds[round][num - 2] != 10
        print_rounds(round, num)
      end
      puts
    end
  end

  def print_rounds(round,num)
    if num == @Rounds[round].length - 1
      puts
    end
    if num == 0 && @Rounds[round][num] == 10
      print("X ")
    elsif num == 1 && @Rounds[round][num] == 10
      print("/ ")
    else
      print("#{@Rounds[round][num]} ")
    end
  end
end 

game = BowlingGame.new
game.draw
