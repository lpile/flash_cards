class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def count
    @cards.count
  end

  def cards_in_category(type)
    @cards.select do |card|
      card.category == type
    end
  end
end
