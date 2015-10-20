class CreateResource < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :order, index: true
    end
  end
end
