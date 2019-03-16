require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/round'
require 'pry'

class RoundTest < Minitest::Test

  # test if card, deck, and round class exists
  def test_classes_exists
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)

    assert_instance_of Card, card_1
    assert_instance_of Deck, deck
    assert_instance_of Round, round
    assert_equal card_1, round.current_card
    assert_equal [], round.turns
  end

  # test take turn method
  def test_take_turn
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    new_turn = round.take_turn("Juneau")

    assert_instance_of Turn, new_turn
    assert_equal true, new_turn.correct?
    assert_equal card_2, round.current_card
  end

  # test second turn on take turn method
  def test_second_turn_on_take_turn
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    round.take_turn("Juneau")
    round.take_turn("Venus")

    assert_equal 2, round.turns.count
    assert_equal "Incorrect", round.turns.last.feedback
    assert_equal 1, round.number_correct
    assert_equal card_3, round.current_card
  end

  # test the number of correct by category
  def test_number_correct_by_category
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)

    round.take_turn("Juneau")
    round.take_turn("Venus")
    round.take_turn("North north west")

    assert_equal 1, round.number_correct_by_category(:STEM)
    assert_equal 1, round.number_correct_by_category(:Geography)
    assert_nil nil, round.number_correct_by_category(:Sport)
  end

  # test the percent of correct answers
  def test_percent_correct
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    round.take_turn("Juneau")

    # test first turn
    assert_equal "Correct!", round.turns.last.feedback
    assert_equal 100.0, round.percent_correct
    assert_equal card_2, round.current_card

    # test second turn
    round.take_turn("Venus")
    assert_equal "Incorrect", round.turns.last.feedback
    assert_equal 50.0, round.percent_correct
    assert_equal card_3, round.current_card

    #test third turn
    round.take_turn("North north west")
    assert_equal "Correct!", round.turns.last.feedback
    assert_equal 66.7, round.percent_correct
    assert_nil nil, round.current_card
  end

  # test the percent of correct answers by category
  def test_percent_correct_by_category
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    round.take_turn("Juneau")

    # test first turn
    assert_equal 100.0, round.percent_correct
    assert_equal 100.0, round.percent_correct_by_category(:Geography)
    assert_nil nil, round.percent_correct_by_category(:Sport)

    # test second turn
    round.take_turn("Venus")
    assert_equal 50.0, round.percent_correct
    assert_equal 100.0, round.percent_correct_by_category(:Geography)
    assert_equal 0.0, round.percent_correct_by_category(:STEM)
    assert_nil nil, round.percent_correct_by_category(:Sport)

    #test third turn
    round.take_turn("North north west")
    assert_equal 66.7, round.percent_correct
    assert_equal 100.0, round.percent_correct_by_category(:Geography)
    assert_equal 50.0, round.percent_correct_by_category(:STEM)
    assert_nil nil, round.percent_correct_by_category(:Sport)
  end

end
