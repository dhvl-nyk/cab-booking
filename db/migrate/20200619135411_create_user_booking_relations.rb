class CreateUserBookingRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_booking_relations do |t|

      t.timestamps
    end
    add_reference :user_booking_relations, :user, foreign_key: true, index: true
    add_reference :user_booking_relations, :booking, foreign_key: true, index: true
  end
end
