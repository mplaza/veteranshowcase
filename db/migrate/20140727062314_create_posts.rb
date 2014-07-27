class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :author
      t.string :publication
      t.boolean :favorite, default: false, null: false
      t.string :url
      t.string :image
      t.datetime :publish_date
      t.boolean :approved, default: false, null: false
      t.boolean :saved, default: false, null: false


      t.timestamps
    end
  end
end
