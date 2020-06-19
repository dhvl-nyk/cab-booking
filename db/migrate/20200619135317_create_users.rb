class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.float :long, null: false
      t.float :lat, null: false
      t.boolean :available, default: true
      t.string :type
      t.timestamps
    end
    add_reference :users, :car, foreign_key: true, index: true

  end
end
