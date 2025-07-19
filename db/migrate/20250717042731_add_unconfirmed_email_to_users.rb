class AddUnconfirmedEmailToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :unconfirmed_email, :string
    # Optional: If you want to search users by unconfirmed_email
    add_index :users, :unconfirmed_email
  end
end
