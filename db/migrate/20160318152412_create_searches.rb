class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.text :company
      t.text :siret
      t.integer :status

      t.timestamps null: false
    end
  end
end
