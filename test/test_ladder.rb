require 'test/unit'
require_relative '../lib/ruby_rube/ladder'
require_relative '../lib/ruby_rube/contestant'

class TestLadder < Test::Unit::TestCase
  def test_init
    contestant = RubyRube::Contestant.new('testing')
    ladder = RubyRube::Ladder.new(contestant)
    assert_equal('testing', ladder.contestant.message)
  end
end
