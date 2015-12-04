class AddCodeNumberToProduct < ActiveRecord::Migration
  def change
    add_column :products, :codeNumber, :string
  end
end
