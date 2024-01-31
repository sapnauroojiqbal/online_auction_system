class AddSoldToToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :sold_to, foreign_key: { to_table: :users }
  end
end
