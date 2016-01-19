class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_subscription, only: [:show, :destroy, :edit, :update]

  def show
    @unread_articles = @subscription.unread_articles
    @blog = @subscription.blog
    @subscription.read_blog!
  end

  def new
    @subscription = current_user.subscriptions.new
    @button_text = '创建'
  end

  def create
    @subscription = current_user.subscriptions.build subscription_params

    if @subscription.save
      redirect_to @subscription, flash: { success: '订阅成功' }
    else
      render :new
    end
  end

  def edit
    @button_text = '保存'
  end

  def update
    if @subscription.update subscription_params
      flash[:success] = '更新成功'
      redirect_to @subscription
    else
      render :edit
    end
  end

  def destroy
    @subscription.destroy
    redirect_to root_path, flash: { success: '取消订阅成功' }
  end

  private

  def find_subscription
    @subscription = current_user.subscriptions.find params[:id]
  end

  def subscription_params
    params.require(:subscription).permit(:blog_name, :blog_link)
  end
end