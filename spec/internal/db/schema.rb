ActiveRecord::Schema.define do
  create_table(:posts, force: true) do |t|
    t.string :title
    t.text :body
    t.timestamps null: false
  end
end
