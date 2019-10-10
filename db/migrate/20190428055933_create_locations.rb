class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.integer :building
      t.integer :floor
      t.integer :room
      t.float :lat
      t.float :lng
      t.timestamps
    end
  end
end
