class CommentsController < ApplicationController
  
  before_filter :redirect_home, :only => [:index, :new, :destroy]
  before_filter :require_login, :except => [:index, :show]
  before_filter :can_edit, :only => [:edit, :update, :destroy]
  
  def index
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def new
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def create
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      redirect_to polymorphic_path(@comment.resource) + '#c' + @comment.id.to_s
    else
      redirect_to polymorphic_path(@comment.resource) + '#comments' + @comment.id.to_s
    end
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to polymorphic_path(@comment.resource) + '#c' + @comment.id.to_s
    else
      render :action => "edit"
    end
  end
  
  def destroy
  end
end
