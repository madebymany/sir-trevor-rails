ActiveRecord::Migration.verbose = false
class CreateSchema < ActiveRecord::Migration
  create_table :articles do |t|
    t.text :content
    t.timestamps
  end
end

