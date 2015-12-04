class AddEnterpriseToProduct < ActiveRecord::Migration
  def change
    add_column :products, :enterprise, :integer
  end
end
