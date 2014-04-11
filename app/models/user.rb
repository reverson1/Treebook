class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :first_name, :last_name, :profile_name  

  has_many :statuses

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  validates :email, presence: true, uniqueness: true
  
  validates :profile_name, presence: true, uniqueness: true, format: {
                            with: /\A[a-zA-Z\-\_]+\Z/,
                            message: 'Must be formatted correctly'
                           }      

  def fullname
    first_name + ' ' + last_name
  end
end