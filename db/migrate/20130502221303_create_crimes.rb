class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.integer :incidntnum
      t.string :category
      t.string :descript
      t.string :dayofweek
      t.datetime :date
      t.time :time
      t.string :pddistrict
      t.string :resolution
      t.string :address
      t.decimal :lat, :precision => 17, :scale => 13
      t.decimal :lon, :precision => 17, :scale => 13

      t.timestamps
    end
  end
end
