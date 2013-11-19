class CommentsController < ApplicationController
  before_action :require_user

  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.build(params.require(:comment).permit(:comment))
  	@comment.user = current_user

  	if @comment.save
   	flash[:notice] = "Your comment was added."
   	redirect_to post_path(@post)
   else
   	render 'posts/show'
   end

  end

  def vote
    @vote = Vote.create(voteable: @comment, user_id: current_user.id, vote: params[:vote])

    if @vote.valid?
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "Your vote was not counted"
    end

    redirect_to :back
  end

end