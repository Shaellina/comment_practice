class PostController < ApplicationController
  before_action(:find_post, only: [:show, :edit, :update, :destroy])
  
  def index # 게시글 다 보여주는 페이지
    @posts = Post.all # [게시글1, 게시글2, 게시글3, ... ]
  end

  def new # 게시글 작성하는 form 페이지
  end

  def create # 작성된 게시글 DB에 넣는 액션
    Post.create(
      title: params[:title],
      content: params[:content],
      user_id: session[:user_id]
    )
    redirect_to '/'
  end

  def show # 1개의 게시글 보는 페이지
  end

  def create_comment # 해당하는 글에 댓글 다는 액션(show)
    Comment.create(
      content: params[:content],
      post_id: params[:id],
    )
    redirect_to :back
  end
  
  def edit
  end
  
  def update
    @post.update(
      title: params[:title],
      content: params[:content]
    )
    redirect_to "/post/show/#{@post.id}"
  end
  
  def destroy
    @post.destroy
    redirect_to '/'
  end
  
  private
  def find_post
    @post = Post.find(params[:id])
  end
  
end
