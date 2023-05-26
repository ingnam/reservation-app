class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :type
      t.string :code
      t.datetime :start_date
      t.datetime :end_date
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :status
      t.string :currency
      t.float :payout_price
      t.float :security_price
      t.float :total_price
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
