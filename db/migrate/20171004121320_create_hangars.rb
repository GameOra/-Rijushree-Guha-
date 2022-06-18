class CreateHangars < ActiveRecord::Migration[5.0]
  def change
    create_table :hangars do |t|
      t.integer :number

      t.timestamps
    end
  end
end
