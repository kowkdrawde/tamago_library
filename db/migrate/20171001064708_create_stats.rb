class CreateStats < ActiveRecord::Migration
  def change
	ActiveRecord::Schema.define do
	enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :stats do |t|
      t.string :name
      t.hstore :content

      t.timestamps null: false
    end
	end
  end
end
