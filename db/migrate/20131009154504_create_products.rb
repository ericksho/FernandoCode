class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :codeText
      t.integer :codeNumber
      t.string :description

      t.timestamps
    end
  end
end
