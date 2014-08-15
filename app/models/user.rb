class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  def self.authenticate!(email, password)
    user = User.where(email: email).first
    return (user.valid_password?(password) ? user : nil) unless user.nil?
    nil
  end
  
end
