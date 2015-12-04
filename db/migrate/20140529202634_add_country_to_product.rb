class AddCountryToProduct < ActiveRecord::Migration
  def change
    add_column :products, :country, :integer
  end
end
