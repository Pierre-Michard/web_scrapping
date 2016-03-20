require 'test_helper'

class FameTest < ActiveSupport::TestCase
  test "parrot has A note" do
    Search.first
    scrap = Fame.new(searches(:parrot))
    assert_equal('A', scrap.note)
  end

  test "inexistant has F note" do
    scrap = Fame.new(searches(:inexistant))
    assert_equal('F', scrap.note)
  end

  test 'data is correct' do
    scrap = Fame.new(searches(:nicomatic))
    assert_equal('{"les_echos":1,"bpi_france":3}', scrap.data)
  end

  test 'company name with space' do
    scrap = Fame.new(searches(:origin))
    assert_equal('{"les_echos":0,"bpi_france":0}', scrap.data)
  end
end