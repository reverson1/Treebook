class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :first_name, :last_name, :profile_name  

  has_many :leafs, :dependent => :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  validates :email, presence: true, uniqueness: true
  
  validates :profile_name, presence: true, 
                            uniqueness: true, 
                            format: {
                              with: /^[a-zA-Z0-9_-]+$/,
                              :multiline => true,
                              message: 'Must be formatted correctly'
                           }      

  def fullname
    first_name + ' ' + last_name
  end
  

  
  def gravatar_url
    email_strip = email.strip
    downcase_email = email_strip.downcase    
    hash = Digest::MD5.hexdigest(downcase_email)
    
    "http://gravatar.com/avatar/#{hash}"
  end

end