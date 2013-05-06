class AddSafetyScoreToCrimes < ActiveRecord::Migration
  def up
    add_column :crimes, :safety_score, :integer, :default => 0
  end

  def down
  	remove_column :crimes, :safety_score
  end
end
