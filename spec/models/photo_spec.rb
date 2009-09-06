require File.dirname(__FILE__) + '/../spec_helper'

describe Photo do
  it "should be valid" do
    Factory.build(:photo).should be_valid
  end

  it "should assign album name" do
    Factory.build(:photo, :album_name => 'album name').album.name.should == 'album name'
  end    
  
  it "should assign location name" do
    Factory.build(:user, :location_name => 'location name').location.name.should == 'location name'
  end    
end
