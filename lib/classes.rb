require_relative 'associatable_b'

class House < SQLObject
  finalize!
  has_many :characters
end

class Character < SQLObject
  finalize!
  belongs_to :house

  has_many :nicknames,
  foreign_key: :owner_id,
  class_name: 'Nickname'
end

class Nickname < SQLObject
  finalize!
  belongs_to :owner,
  foreign_key: :owner_id,
  class_name: 'Character'
end
