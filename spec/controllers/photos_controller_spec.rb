require File.dirname(__FILE__) + '/../spec_helper'
 
describe PhotosController do
  fixtures :all
  integrate_views
  
  before do
    @album = Factory(:album)
  end
  
  it "index action should render index template" do
    get :index, :album_id => @album
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:photo, :album => @album), :album_id => @album
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :album_id => @album
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Photo.any_instance.stubs(:valid?).returns(false)
    post :create, :album_id => @album
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Photo.any_instance.stubs(:valid?).returns(true)
    post :create, :album_id => @album
    response.should redirect_to(album_photo_url(@album, assigns[:photo]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:photo, :album => @album), :album_id => @album
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    photo = Factory(:photo, :album => @album)
    Photo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => photo, :album_id => @album
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Photo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:photo, :album => @album), :album_id => @album
    response.should redirect_to(album_photo_url(@album, assigns[:photo]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    photo = Factory(:photo, :album => @album)
    delete :destroy, :id => photo, :album_id => @album
    response.should redirect_to(album_photos_url(@album))
    Photo.exists?(photo.id).should be_false
  end
end
