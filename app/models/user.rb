class User < ActiveRecord::Base
  # Connects this user object to Hydra behaviors. 
  include Hydra::User
  include Blacklight::User

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # attr_accessible :title, :body

  attr_accessor :groups
  def groups
    # TODO: Get groups from DB / rolemapper / other?
    unless @groups
      @groups = []

      # TODO: Actually check for external ip list/range, not just mine
      @groups.push("library") if current_sign_in_ip == "128.223.223.89"

      # TODO: This is WRONG
      @groups.push("reviewer") if email == "jechols@uoregon.edu"
    end

    return @groups
  end

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account. 
  def to_s
    email
  end
end
