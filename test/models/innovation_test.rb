require 'test_helper'

class InnovationTest < ActiveSupport::TestCase
  test "parrot has A note" do
    Search.first
    scrap = Innovation.new(searches(:parrot))
    assert_equal('A', scrap.note)
  end

  test "inexistant has F note" do
    scrap = Innovation.new(searches(:inexistant))
    assert_equal('F', scrap.note)
  end

  test 'data is correct' do
    scrap = Innovation.new(searches(:nicomatic))
    assert_equal('{"google":307,"inpi":27}', scrap.data)
  end
end