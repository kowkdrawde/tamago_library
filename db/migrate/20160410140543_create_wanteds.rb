class CreateWanteds < ActiveRecord::Migration
  def change
    create_table :wanteds do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.text :wantreason
      t.timestamps null: false
    end
  end
end
