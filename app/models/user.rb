class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable 

  # Setup accessible (or protected) attributes for your model
   attr_accessible :password, :password_confirmation, :remember_me
   attr_accessible :name, :email, :ip, :cookie
end
