class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :key, null: false
      t.text :source, null: false

      t.timestamps
    end
  end
end
