class RenameSiretToSiren < ActiveRecord::Migration
  def change
    rename_column :searches, :siret, :siren
  end
end
