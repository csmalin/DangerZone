class FixColumnName < ActiveRecord::Migration
  def up
  	rename_column :crimes, :safety_score, :threat_level
  end

  def down
  end
end
