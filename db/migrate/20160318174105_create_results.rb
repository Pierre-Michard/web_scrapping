class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :note
      t.text :data

      t.timestamps null: false
    end
  end
end
