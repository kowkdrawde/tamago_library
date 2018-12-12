class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.boolean :availability
      t.string :isbn
      t.string :country
      t.string :loc
      t.text :tags
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
