require File.dirname(__FILE__) + '/../spec_helper'

describe Album do
  it "should be valid" do
    Factory.build(:album).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:album, :name => '').should_not be_valid
  end
end
