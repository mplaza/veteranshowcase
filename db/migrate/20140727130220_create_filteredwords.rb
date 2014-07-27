class CreateFilteredwords < ActiveRecord::Migration
  def change
    create_table :filteredwords do |t|
      t.string :negativesearch
      t.string :admin_id

      t.timestamps
    end
  end
end
