class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :code
      t.string :holder, null: true
      t.datetime :time, null: true

      t.timestamps
    end
  end
end
