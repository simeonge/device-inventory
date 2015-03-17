class AddAvailableToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :available, :boolean
  end
end
