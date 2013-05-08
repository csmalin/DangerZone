class RemoveDistanceColumn < ActiveRecord::Migration
  def up
    remove_column :crimes, :distance
  end

  def down
    add_column :crimes, :distance, :decimal
  end
end
