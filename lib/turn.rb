class Turn

  attr_reader :guess, :card

  def initialize(guess, card)
    @guess = guess
    @card = card
  end

  # return a boolean indicating if the guess matched the answer on the Card
  def correct?
    card.answer == @guess
  end

  # return "correct" or "incorrect" depending on guess = answer
  def feedback
    if correct?
      "Correct!"
    else
      "Incorrect"
    end
  end

end
