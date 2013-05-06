class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.integer  :incidntnum
      t.string   :category
      t.string   :descript
      t.string   :dayofweek
      t.integer  :date
      t.integer  :time
      t.string   :pddistrict
      t.string   :resolution
      t.string   :address
      t.decimal  :latitude, :precision => 17, :scale => 13
      t.decimal  :longitude, :precision => 17, :scale => 13

      t.timestamps
    end
  end
end
