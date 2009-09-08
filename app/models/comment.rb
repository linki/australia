class Comment < ActiveRecord::Base
  #attr_accessible :text, :user_name
  
  validates_presence_of :text
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user  
  
  getter_and_setter_for :user => :name
end
