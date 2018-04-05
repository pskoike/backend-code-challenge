class CreateDistances < ActiveRecord::Migration[5.1]
  def change
    create_table :distances do |t|
      t.string :origin
      t.string :destination
      t.integer :km

      t.timestamps
    end
  end
end
