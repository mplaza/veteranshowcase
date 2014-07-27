class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :searchauthor
      t.string :admin_id

      t.timestamps
    end
  end
end
