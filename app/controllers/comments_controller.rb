class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to post_path(@post)
    end
	end
end
