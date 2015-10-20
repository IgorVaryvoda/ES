class AddTransactionDetailsToOrder < ActiveRecord::Migration
  def up
    add_column :orders, :transaction_details, :text
  end

  def down
    remove_column :orders, :transaction_details, :text
  end
end
