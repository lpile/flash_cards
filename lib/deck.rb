class Deck

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  # number of cards in deck
  def count
    @cards.count
  end

  # select cards by category
  def cards_in_category(type)
    @cards.select do |card|
      card.category == type
    end
  end

end
