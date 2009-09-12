class CommentsController < InheritedResources::Base
  belongs_to :album

  respond_to :html, :xml, :json, :js

  def create
    create! do |response|
      response.html { redirect_to parent_path }
      response.js
    end
  end
end
