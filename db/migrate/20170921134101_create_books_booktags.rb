class CreateBooksBooktags < ActiveRecord::Migration
  def change
    create_table :books_booktags, id: false do |t|
      t.references :book, index: true, foreign_key: true
      t.references :booktag, index: true, foreign_key: true
    end
  end
end
