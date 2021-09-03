require 'rspec'
require './lib/card'

describe Card do
  before do
    @card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
  end

  describe '#initialize' do
    it 'is an instance of card' do
      expect(@card).to be_a Card
    end

    it 'is has attributes' do
      expect(@card.question).to eq("What is the capital of Alaska?")
      expect(@card.answer).to eq("Juneau")
      expect(@card.category).to eq(:Geography)
    end
  end
end
