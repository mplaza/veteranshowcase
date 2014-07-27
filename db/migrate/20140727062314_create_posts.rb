class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :publication
      t.boolean :favorite
      t.string :url
      t.string :image
      t.boolean :approved
      t.boolean :saved

      t.timestamps
    end
  end
end
