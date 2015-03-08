class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :os
      t.string :model
      t.string :code

      t.timestamps
    end
  end
end
