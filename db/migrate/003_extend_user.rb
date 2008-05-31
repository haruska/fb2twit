class ExtendUser < ActiveRecord::Migration
  def self.up
    add_column :users, :remove_is, :boolean, :null => false, :default => true
    add_column :users, :ignore, :string
  end

  def self.down
    remove_column :users, :remove_is
    remove_column :users, :ignore
  end
end
