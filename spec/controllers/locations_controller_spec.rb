require File.dirname(__FILE__) + '/../spec_helper'
 
describe LocationsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:location)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Location.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Location.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(location_url(assigns[:location]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:location)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    location = Factory(:location)
    Location.any_instance.stubs(:valid?).returns(false)
    put :update, :id => location
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Location.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:location)
    response.should redirect_to(location_url(assigns[:location]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    location = Factory(:location)
    delete :destroy, :id => location
    response.should redirect_to(locations_url)
    Location.exists?(location.id).should be_false
  end
end
