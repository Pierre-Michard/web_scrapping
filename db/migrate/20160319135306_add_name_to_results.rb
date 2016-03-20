class AddNameToResults < ActiveRecord::Migration
  def change
    add_column :results, :name, 'text'
  end
end
