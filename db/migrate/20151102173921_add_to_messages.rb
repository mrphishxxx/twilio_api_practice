class AddToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :body, :string
    add_column :messages, :to, :string
    add_column :messages, :from, :string
  end
end
