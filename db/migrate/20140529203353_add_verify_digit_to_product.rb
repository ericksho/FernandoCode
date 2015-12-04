class AddVerifyDigitToProduct < ActiveRecord::Migration
  def change
    add_column :products, :verifyDigit, :integer
  end
end
