class CreateSearchresults < ActiveRecord::Migration
  def change
    create_table :searchresults do |t|
      t.string :title
      t.string :publication
      t.boolean :favorite
      t.string :url
      t.string :image
      t.boolean :approvedpost
      t.boolean :starredpost

      t.timestamps
    end
  end
end
