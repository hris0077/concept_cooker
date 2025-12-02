class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
