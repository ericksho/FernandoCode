class RemoveObsoleteColumns2 < ActiveRecord::Migration
  def change
  	remove_column :products, :original_code	
  end
end
