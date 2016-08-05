class Activationemail < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, default: true
    add_column :users, :activation_token, :string, default: ""

    add_index :users, :activation_token
  end
end
