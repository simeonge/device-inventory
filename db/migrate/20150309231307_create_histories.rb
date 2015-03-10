class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :code
      t.string :holder
      t.datetime :timein
      t.datetime :timeout

      t.timestamps
    end
  end
end
