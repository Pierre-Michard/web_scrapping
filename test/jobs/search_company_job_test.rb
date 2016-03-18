require 'test_helper'

class SearchCompanyJobTest < ActiveJob::TestCase
  test "search parrot" do
    SearchCompanyJob.new.perform(Search.first.id)
  end
end
