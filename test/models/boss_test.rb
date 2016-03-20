require 'test_helper'

class BossTest < ActiveSupport::TestCase
  test "find Parrot boss" do
    Search.first
    scrap = Boss.new(searches(:parrot))
    assert_equal('A', scrap.note)
  end

  test "inexistant has F note" do
    scrap = Boss.new(searches(:inexistant))
    assert_equal('F', scrap.note)
  end

  test 'data is correct' do
    scrap = Boss.new(searches(:nicomatic))
    assert_equal('<a href="https://fr.linkedin.com/pub/dir/?first=Olivier&last=Nicollin">M Olivier NICOLLIN</a>', scrap.data)
  end


end