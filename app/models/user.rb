class User < ApplicationRecord
  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :token_authenticatable
 
  after_create :assign_default_role
  before_create :ensure_authentication_token

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  # If the user has no access_token, generate one.
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_access_token
    end
  end

  private
    def generate_access_token
        token = Devise.friendly_token
    end
end
