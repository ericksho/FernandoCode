class AddOriginalCodeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :original_code, :string
  end
end
