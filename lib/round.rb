class Round
  attr_reader :deck, :turns, :current_card

  def initialize(deck)
    @deck = deck
    @turns = []
    @current_card = 0
    @correct = []
  end

  def current_card
    deck.cards[@current_card]
  end

  def take_turn(guess)
    new_turn = Turn.new(guess, self.current_card)
    @turns << new_turn
    @current_card += 1
    if @turns.last.correct?
      @correct << @turns.last
    end
    new_turn
  end

  def number_correct
    @correct.count
  end

  def number_correct_by_category(category)
    @correct.count do |correct|
      correct.card.category == category
    end
  end

  def percent_correct
    ((@correct.count.to_f/@turns.count) * 100.0).round(1)
  end

  def percent_correct_by_category(category)
    @number_in_category = [] # resets category array
    @turns.select do |turn|
      if turn.card.category == category
        @number_in_category << turn
      end
    end
    ((number_correct_by_category(category).to_f/@number_in_category.count) * 100.0).round(1)
  end

  # intro
  def start
    p "Welcome! You're playing with #{@deck.count} cards"
    p "-------------------------------------------"
    p "This is card number #{@current_card + 1} out of #{@deck.count}"
    p "Question: #{current_card.question}"
    self.middle
  end

  # middle of program
  def middle
    guess = gets.chomp.to_s
    take_turn(guess)
    p @turns.last.feedback
    if self.current_card == nil
      self.end # Jumps to end method if there isn't any cards in deck
    else
      p "This is card number #{@current_card + 1} out of #{deck.count}"
      p "Question: #{current_card.question}"
      self.middle # Jumps to start of middle method
    end
  end

  # outro
  def end
    p "************************ GAME OVER! ************************"
    p "You had #{self.number_correct} correct guess out of #{@turns.count} for a total score of #{self.percent_correct}%"
    p "Geography - #{percent_correct_by_category(:Geography)}% correct"
    p "STEM - #{percent_correct_by_category(:STEM)}% correct"
    p "Sports - #{percent_correct_by_category(:Sports)}% correct"
    p "************************************************************"
  end
end
