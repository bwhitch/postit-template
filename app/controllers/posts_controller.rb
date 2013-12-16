class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
   @post = Post.new(post_params)
   @post.user = current_user
  
   if @post.save
   	flash[:notice] = "Your post was created"
   	redirect_to posts_path
   else
   	render 'new'
   end
  end

  def edit; end

  def update
  	if @post.update(post_params)
  		flash[:notice] = "Post was updated"
  		redirect_to posts_path
  	else
  		render :edit
  	end
  end
  
  def vote
    @vote = Vote.create(voteable: @post, user_id: current_user.id, vote: params[:vote])

    if @vote.valid?
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "You have previously voted on this post."
    end

    redirect_to :back
  end
  
  private

  def post_params
  	params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
     @post = Post.find_by(slug: params[:id])
  end

end
