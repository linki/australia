class User < ActiveRecord::Base
  attr_accessible :name, :email, :location_name
  
  validates_presence_of :name
  
  belongs_to :location
  
  getter_and_setter_for :location => :name
end