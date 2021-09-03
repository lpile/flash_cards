require 'rspec'
require './lib/card'
require './lib/turn'

describe Turn do
  before do
    @card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
    @turn = Turn.new("Juneau", @card)
  end

  describe '#initialize' do
    it 'is an instance of turn' do
      expect(@turn).to be_a Turn
    end

    it 'is has attributes' do
      expect(@turn.guess).to eq("Juneau")
      expect(@turn.card).to eq(@card)
    end
  end

  describe '#correct?' do
    it 'can return true if the guess was correct' do
      expect(@turn.correct?).to eq(true)
    end

    it 'can return false if the guess was incorrect' do
      card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
      turn = Turn.new("Denver", card)
      expect(turn.correct?).to eq(false)
    end
  end

  describe '#feedback' do
    it 'can return correct for feedback of correct guess' do
      expect(@turn.feedback).to eq("Correct!")
    end

    it 'can return incorrect for feedback of incorrect guess' do
      card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
      turn = Turn.new("Denver", card)
      expect(turn.feedback).to eq("Incorrect")
    end
  end
end
