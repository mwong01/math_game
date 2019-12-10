require "./player"
require "./question"

class Game 
  attr_reader :question
  attr_accessor :p1, :p2, :current_p

  def initialize(p1_name, p2_name)
      @p1 = Player.new(p1_name)
      @p2 = Player.new(p2_name)
      @question = Question.new
      @current_p = p1
      @game_over = false
  end

  def start
    question.ask(current_p)
    answer = $stdin.gets.chomp.to_i
    if (!question.check_answer(answer))
      current_p === p1 ? p1.lose_life : p2.lose_life
      if p1.life == 0 || p2.life == 0
        self.game_over = true
      end
      message(false) 
    else
      message(true)
  end
end

  def message(correct)
    puts correct ? "#{current_p.name}: Yes, you are correct!" : "#{current_p.name} No, you're wrong!"
    puts "#{p1.name}: #{p1.score} vs. #{p2.name}: #{p2.score}"
    if (@game_over)
      puts current_p.name == p1.name ? "#{p2.name} wins with a score of #{p2.score}" : "#{p1.name} wins with a score of #{p1.score}"
      puts "----- GAME OVER -----"
      puts "Good bye!"
      exit(0)
    else
      puts "----- NEW TURN -----"
      next_play
  end
end

  def next_play
    if (current_p.name == p1.name)
      self.current_p = p2
    else 
      self.current_p = p1
  end
end

end

