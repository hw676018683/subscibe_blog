class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:github]

  has_many :subscriptions, dependent: :destroy
  has_many :subscibe_blogs, through: :subscriptions, source: :blog
  has_many :authorizations, dependent: :destroy

  def update_with_password(params = {})
    if !params[:current_password].blank? || !params[:password].blank? || !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      update_without_password(params)
    end
  end

  def self.from_github hash_auth
    uid, data = hash_auth['uid'].to_s, hash_auth['info']

    user = User.joins(:authorizations).where(authorizations: { uid: uid, provider: 'github' }).first
    return user if user

    user = User.new email: data['email'], password: Devise.friendly_token[0, 20]
    if user.save
      user.authorizations << Authorization.new(uid: uid, provider: 'github')
    end
    user
  end

  def admin?
    email.in? Settings.admin_emails
  end
end
