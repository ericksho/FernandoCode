class RemoveCodeNumberFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :codeNumber, :integer
  end
end
