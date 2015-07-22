class PostsController < ActionController::Base
  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_attributes)

    if @post.save
      redirect_to post_show_path(@post)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_attributes)
      redirect_to post_show_path(@post)
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
