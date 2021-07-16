class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :name
      t.integer :number
      t.string :district
      t.string :city
      t.string :state
      t.string :zip_code
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
