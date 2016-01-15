class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_github(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:success] = '登录成功'
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:danger] = @user.errors.full_messages.join('，')
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:danger] = '登录失败'
    redirect_to root_path
  end
end