require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-migrations'
require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,               Serial
  property :name,             String
  property :email,            String, required: true
  property :password_digest,  Text

  attr_accessor :password_confirmation
  attr_reader :password
  validates_confirmation_of :password, :confirm => :password_confirmation
  validates_with_method :password
  validates_format_of :email, :as => :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
