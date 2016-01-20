class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_blog, only: [:new, :create]
  before_action :ensure_admin, only: [:index, :destroy]

  def new
    @feedback = @blog.feedbacks.new
  end

  def create
    @feedback = @blog.feedbacks.build feedback_params

    if @feedback.save
      redirect_to root_path, flash: { success: '反馈成功' }
    else
      render :new
    end
  end

  def index
    @feedbacks = Feedback.all
  end

  def destroy
    @feedback = Feedback.find params[:id]
    @feedback.destroy
    flash[:success] = '删除成功'
    redirect_to feedbacks_path
  end

  private

  def find_blog
    @blog = Blog.find params[:blog_id]
  end

  def feedback_params
    params.require(:feedback).permit(:content)
  end

  def ensure_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
