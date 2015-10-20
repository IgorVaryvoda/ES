class CreateRate < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :level
      t.string :time
      t.float :rate
    end
  end
end
