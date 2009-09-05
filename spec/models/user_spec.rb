require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should be valid" do
    Factory.build(:user).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:user, :name => '').should_not be_valid
  end
  
  it "should assign location name" do
    Factory.build(:user, :location_name => 'location name').location.name.should == 'location name'
  end    
end
