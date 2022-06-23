class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :product
      t.decimal :total_wieght
      t.integer :quantity

      t.timestamps
    end
  end
end
