class Search < ActiveRecord::Base
  has_many :results

  enum status: [ :searching, :done]

  def new_result(*args)
    self.results.create(args)
  end
end
