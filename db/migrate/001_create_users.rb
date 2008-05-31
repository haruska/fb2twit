class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :facebook_id, :null => false
      t.text    :session
      t.string  :twitter_name
      t.string  :twitter_pass
      t.string  :last_status
      t.boolean :bad_pass
      t.timestamps
    end
    add_index :users, :facebook_id, :unique => true
  end

  def self.down
    drop_table :users
  end
end
