class AddOrderToLineItem < ActiveRecord::Migration[7.2]
  def change
    add_reference :line_items, :order, null: true, foreign_key: true
    change_column :line_items, :cart_id, :integer, null: true
  end
end
