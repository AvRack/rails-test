class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :destroy]

  def new
    if signed_in? 
      @post = current_user.posts.build 
    else
      render 'static_pages/home'
    end
  end

 def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'posts/new'
    end
  end


  def destroy
    Post.find(params[:id]).destroy
    redirect_to root_url
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def index
    if params[:tag]
      @posts = Post.paginate(page: params[:page],:per_page => 5).tagged_with(params[:tag])
    else
      @posts = Post.paginate(page: params[:page],:per_page => 5)
    end
  end

  private

    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_url if @post.nil?
    end
end