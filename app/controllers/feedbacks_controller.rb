class FeedbacksController < ApplicationController
  before_action :find_blog

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

  private

  def find_blog
    @blog = Blog.find params[:blog_id]
  end

  def feedback_params
    params.require(:feedback).permit(:content)
  end
end
