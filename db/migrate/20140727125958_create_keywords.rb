class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :searchterm
      t.string :admin_id

      t.timestamps
    end
  end
end
