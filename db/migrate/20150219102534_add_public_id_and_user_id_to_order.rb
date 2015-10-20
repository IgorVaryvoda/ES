class AddPublicIdAndUserIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :public_id, :string
  end
end
