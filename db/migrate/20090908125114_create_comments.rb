class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :text
      t.references :commentable, :polymorphic => true
      t.references :user
      t.timestamps
    end
    
    add_index :comments, [:commentable_id, :commentable_type]
  end
  
  def self.down
    drop_table :comments
  end
end
