class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.string :publisher
      t.integer :year
      t.string :genre

      t.timestamps
    end
  end
end
