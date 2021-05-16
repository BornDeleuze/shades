class AddRareToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :rare, :boolean, :default => false
  end
end
