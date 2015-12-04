class AddProductToProduct < ActiveRecord::Migration
  def change
    add_column :products, :product, :integer
  end
end
