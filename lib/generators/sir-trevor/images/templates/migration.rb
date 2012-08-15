class CreateSirTrevorImageTable < ActiveRecord::Migration
  def change
    create_table :sedit_images do |t|
      t.string :file, :null => false
      t.timestamps
    end
    add_index :sedit_images, :file
  end
end