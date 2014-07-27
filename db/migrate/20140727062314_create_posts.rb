class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :author
      t.string :publication
      t.boolean :favorite, default: false, null: false
      t.string :url
      t.string :image
      t.datetime :publish_date, default: "2001-02-03T00:00:00+00:00", null:false
      t.boolean :approved, default: false, null: false
      t.boolean :saved, default: false, null: false


      t.timestamps
    end
  end
end
