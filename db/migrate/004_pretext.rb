class Pretext < ActiveRecord::Migration
  def self.up
    add_column :users, :pretext, :string
  end

  def self.down
    remove_column :users, :pretext
  end
end
