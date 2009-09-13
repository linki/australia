class CommentsController < InheritedResources::Base
  belongs_to :album

  respond_to :html, :xml, :json, :js

  def create
    create! do |response|
      response.html { redirect_to parent_path }
      response.js
    end
    cookies[:user_name] = @comment.user.name if @comment.user
  end
end
