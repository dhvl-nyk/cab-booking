class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :registration_number, null: false
      t.string :modelname
      t.string :status, null: false
      t.timestamps
    end
  end
end
