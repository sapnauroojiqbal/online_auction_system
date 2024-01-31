# db/migrate/xxxxxxxxxx_update_users.rb
class UpdateUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phone_number
    remove_column :users, :street
    remove_column :users, :city
    remove_column :users, :province
    remove_column :users, :country
    remove_column :users, :postal_code

    add_column :users, :address, :string
    add_column :users, :gender, :string
  end
end

