require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-migrations'

class User

  include DataMapper::Resource

  property :id,               Serial
  property :name,             String
  property :email,            String
  property :password_digest,  Text

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
end
