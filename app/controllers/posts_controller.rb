class PostsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(posts: { user_id: @users.id })
  end

  def show
    @posts = Post.find(params[:id])
  end

  def new
    @posts = Post.new
  end

  def create
    add_post = Post.new(add_post_data)
    add_post.likes_counter = 0
    add_post.comments_counter = 0
    respond_to do |format|
      format.html do
        if add_post.save
          redirect_to user_posts_path(current_login), notice: 'Success: Post added!'
        else
          render :new, status: 'Error: Post not added!'
        end
      end
    end
  end

  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    redirect_to user_post_path(current_login.id, @posts.post_id),
                notice: "Successfully deleted the post #{@posts.title}."
  end

  private

  def add_post_data
    params.require(:posts).permit(:title, :text)
  end
end
