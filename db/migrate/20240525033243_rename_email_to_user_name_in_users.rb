class RenameEmailToUserNameInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :email, :user_name
  end
end
