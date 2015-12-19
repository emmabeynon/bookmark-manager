require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-migrations'
require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,               Serial
  property :name,             String
  property :email,            String, required: true, unique: true
  property :password_digest,  Text

  attr_accessor :password_confirmation, :attempted_password
  attr_reader :password

  validates_confirmation_of :password, :confirm => :password_confirmation
  validates_with_method :password
  validates_format_of :email, :as => :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(:email => email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end
end