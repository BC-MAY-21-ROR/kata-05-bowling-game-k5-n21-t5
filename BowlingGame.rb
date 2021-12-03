#CLASE DE BOWLING
class BowlingGame
  def initialize
    @Rounds = [[0, 0, 0], [0, 0, 0], [0, 0, 0 ], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0, 0]]
    @contador = 1
  end

  def draw
    (0..@contador-1).each do |round|
      puts "\nRound #{round + 1} \n"
      (0..(@Rounds[round].length) - 1).each do |num|
        next if round == 9 && num == 2 && @Rounds[round][num - 1] + @Rounds[round][num - 2] != 10
        print_rounds(round, num)
      end
      puts
    end
  end

  def roll
    while @contador <= 9 do
      (0..@contador).each do |round|
        score = 10
        (0..(@Rounds[round].length) - 2).each do |num|
          strike=rand(0..score)
          @Rounds[round][num] = strike
          score -= strike
        end
      end 
      @contador+=1     
    end
  end
  
  def hola
    print(@Rounds)
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
game.roll
game.draw
game.hola
