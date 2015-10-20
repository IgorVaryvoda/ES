
class ChangeColumnOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.rename :status, :aasm_state
    end
  end
end
