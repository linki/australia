require File.dirname(__FILE__) + '/../spec_helper'

describe Comment do
  it "should be valid" do
    Factory.build(:comment).should be_valid
  end
  
  it "should require a text" do
    Factory.build(:comment, :text => '').should_not be_valid
  end  
end
