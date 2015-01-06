class AddDefaultValueToUserTrackerToken < ActiveRecord::Migration
  def change
    change_column :users, :tracker_token, :string, default: ''
  end
end
