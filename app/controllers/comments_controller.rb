class CommentsController < InheritedResources::Base
  access_control do
    allow logged_in
    allow anonymous, :to => :create
  end
    
  belongs_to :album

  respond_to :html, :xml, :json
  respond_to :js, :only => :create

  def create
    create! do |response|
      response.html { redirect_to parent_path }
      response.js
    end
    cookies[:user_name] = @comment.user.name if @comment.user
  end
  
  destroy! { parent_path }
end
