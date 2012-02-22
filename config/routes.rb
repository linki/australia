ActionController::Routing::Routes.draw do |map|
  map.login  'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'  

  map.resource :session
    
  map.resources :albums, :member => { :bundle => :post } do |albums|
    albums.resources :photos, :collection => { :sort => :put, :descriptions => :get, :update_multiple => :put }
    albums.resources :comments
  end
  
  map.resources :comments
  
  map.resources :users
  
  map.root :albums

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
