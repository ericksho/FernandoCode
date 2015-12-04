class RemoveObsoleteColumns < ActiveRecord::Migration
  def change
  	remove_column :products, :codeText
  	remove_column :products, :codeNumber
  end
end
