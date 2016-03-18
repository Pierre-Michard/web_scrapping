class ResultBelongsToSearch < ActiveRecord::Migration
  def change
    add_reference :results, :search, index: true, foreign_key: true
  end
end
