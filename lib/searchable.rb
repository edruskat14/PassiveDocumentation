require_relative 'db_connection'
require_relative 'sql_object'

module Searchable

  def where(params)
    claves = params.keys
    valores = params.values
    mapa = claves.map { |x| "#{x} = ?"}.join(' AND ')
    found = DBConnection.execute(<<-SQL, *valores)
    SELECT
      *
    FROM
      #{table_name}
    WHERE
      #{mapa}
    SQL

    parse_all(found)
  end

end

class SQLObject
  extend Searchable
end
