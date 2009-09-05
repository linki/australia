require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  it "should be valid" do
    Factory.build(:location).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:location, :name => '').should_not be_valid
  end
end
