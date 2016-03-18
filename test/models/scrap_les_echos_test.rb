require 'test_helper'

class ScrapLesEchosTest < ActiveSupport::TestCase
  test "parrot has A note" do
    Search.first
    scrap = ScrapLesEchos.new(Search.first)
    assert('A', scrap.note)
  end

  test "unknown has F note" do
    scrap = ScrapLesEchos.new(Search.second)
    assert('F', scrap.note)
  end
end