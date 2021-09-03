require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/round'

describe Round do
  before do
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @cards = [@card_1, @card_2, @card_3]
    @deck = Deck.new(@cards)
    @round = Round.new(@deck)
  end

  describe '#initialize' do
    it 'is an instance of round' do
      expect(@round).to be_a Round
    end

    it 'is has attributes' do
      expect(@round.deck).to eq(@deck)
      expect(@round.turns).to eq([])
      expect(@round.current_card).to eq(@card_1)
    end
  end

  describe '#current card' do
    it 'can return the current card in deck' do
      expect(@round.current_card).to eq(@card_1)
      @round.take_turn("Juneau")
      expect(@round.current_card).to eq(@card_2)
    end
  end

  describe '#take_turn' do
    it 'can add to turns array when taking a turn' do
      turn = @round.take_turn("Juneau")
      expect(turn.correct?).to be true
      expect(@round.turns).to eq([turn])
    end

    it 'can add to turns arrays correctly when taking two turns' do
      turn_1 = @round.take_turn("Juneau")
      turn_2 = @round.take_turn("Earth")
      expect(turn_2.correct?).to be false
      expect(@round.turns).to eq([turn_1, turn_2])
    end
  end

  describe '#number_correct' do
    it 'can return the correct number of guesses' do
      @round.take_turn("Denver")
      expect(@round.number_correct).to eq(0)
      @round.take_turn("Mars")
      expect(@round.number_correct).to eq(1)
    end
  end

  describe '#number_correct_by_category' do
    it 'can return the correct number of guesses per category' do
      @round.take_turn("Juneau")
      expect(@round.number_correct_by_category(:Geography)).to eq(1)
      @round.take_turn("Earth")
      expect(@round.number_correct_by_category(:STEM)).to eq(0)
    end
  end

  describe '#percent_correct' do
    it 'can return the percent of correct guesses' do
      @round.take_turn("Juneau")
      expect(@round.percent_correct).to eq(100.0)
      @round.take_turn("Earth")
      expect(@round.percent_correct).to eq(50.0)
    end
  end

  describe '#percent_correct_by_category' do
    it 'can return the percent of correct guesses per category' do
      @round.take_turn("Juneau")
      expect(@round.percent_correct_by_category(:Geography)).to eq(100.0)
      @round.take_turn("Earth")
      expect(@round.percent_correct_by_category(:STEM)).to eq(0.0)
    end
  end
end
