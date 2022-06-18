class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :wieght
      t.references :hangar, foreign_key: true

      t.times