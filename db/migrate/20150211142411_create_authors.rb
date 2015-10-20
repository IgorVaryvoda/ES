class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.string :discipline
      t.string :description
      t.float :raiting
      t.integer :completed_orders
      t.string :avatar

      t.timestamps
    end
  end
end
