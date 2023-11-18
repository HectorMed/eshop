class AddNullFalseToProductFields < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :title, false
    change_column :products, :description, false
    change_column :products, :price, false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
