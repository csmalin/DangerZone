class CreateSexualOffenders < ActiveRecord::Migration
  def change
    create_table :sexual_offenders do |t|

      t.timestamps
    end
  end
end
