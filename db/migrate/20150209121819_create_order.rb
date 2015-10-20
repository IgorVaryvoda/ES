class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :topic
      t.text :details
      t.string :status
      t.integer :price
      t.string :academic_level
      t.string :discipline
      t.string :type_of_paper
      t.integer :pages
      t.datetime :deadline

      t.timestamps
    end
  end
end
