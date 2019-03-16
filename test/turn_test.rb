require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/turn'
require 'pry'

class TurnTest < Minitest::Test

  # test if card class exists
  def test_card_exists
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)

    assert_instance_of Card, card
  end

  # test if turn class exists
  def test_turn_exists
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
    turn = Turn.new("Juneau", card)

    assert_instance_of Turn, turn
  end

  # test turn has card
  def test_turn_has_card
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
    turn = Turn.new("Juneau", card)

    assert_equal turn.card, card
  end

  # test turn has guess
  def test_turn_has_guess
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
    turn = Turn.new("Juneau", card)

    assert_equal "Juneau", turn.guess
  end

  # test turn has correct answer
  def test_turn_has_correct
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
    turn = Turn.new("Juneau", card)

    assert_equal true, turn.correct?
  end

  # test turn has incorrect answer
  def test_turn_has_incorrect
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
    turn = Turn.new("Denver", card)

    assert_equal false, turn.correct?
  end

  # test turn has correct feedback
  def test_turn_has_correct_feedback
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
    turn = Turn.new("Juneau", card)

    assert_equal "Correct!", turn.feedback
  end

  # test turn has incorrect feedback
  def test_turn_has_incorrect_feedback
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geograpy)
    turn = Turn.new("Denver", card)

    assert_equal "Incorrect", turn.feedback
  end

end
