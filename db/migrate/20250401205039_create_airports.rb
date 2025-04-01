class CreateAirports < ActiveRecord::Migration[8.0]
  def change
    create_table :airports do |t|
      t.string :iata

      t.timestamps
    end
    add_index :airports, :iata, unique: true
  end
end
