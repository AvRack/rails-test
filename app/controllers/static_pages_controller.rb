class StaticPagesController < ApplicationController
  def home
  	@posts = Post.first(5)
  end
end
