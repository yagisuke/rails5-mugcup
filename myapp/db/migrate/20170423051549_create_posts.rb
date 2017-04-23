class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer null: :id
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
