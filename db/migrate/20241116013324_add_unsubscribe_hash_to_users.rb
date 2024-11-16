class AddUnsubscribeHashToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :unsubscribe_hash, :string
  end
end
