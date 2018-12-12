class CreateMatchedsUsers < ActiveRecord::Migration
  def change
    create_table :matcheds_users, id: false do |t|
      t.references :matched, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
