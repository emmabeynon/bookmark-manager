require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-migrations'

class Tag

  include DataMapper::Resource

  has n, :links, through: Resource

  property :id,    Serial
  property :name, String

end
