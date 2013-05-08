class AddDistanceColumn < ActiveRecord::Migration
  def up
    add_column :crimes, :distance, :decimal
  end

  def down
    remove_column :distance
  end
end
