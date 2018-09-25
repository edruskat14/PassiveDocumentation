require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject
  def self.columns
    unless @collums
      results = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL
    end
    @collums ||= results.first.map {|el| el.to_sym}
  end

  def self.finalize!
      self.columns.each do |col|
        define_method(col) do
          self.attributes[col]
        end
        define_method("#{col}=") do |arg|
          self.attributes[col] = arg
        end
      end
  end

  def self.get(k)
    self.attributes[k]
  end

  def self.set(a, b)
    @attributes[a] = b
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name = self.to_s.downcase + "s"
  end

  def self.all
    todos = DBConnection.execute(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL
    todos.map { |hash| self.new(hash) }
  end

  def self.parse_all(results)
    results.map { |hash| self.new(hash) }
  end

  def self.find(id)
    self.all.each do |obj|
      return obj if obj.id == id
    end
    return nil
  end

  attr_accessor :attributes, :columns

  def initialize(params = {})
    params.each do |key, val|
      if self.class.columns.include?("#{key}".to_sym)
        self.send("#{key}=", val)
      else
        raise "unknown attribute '#{key.to_s}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    att = []
    @attributes.each do |_, v|
      att << v
    end
    att
  end

  def insert
    col = self.class.columns.drop(1)
    col_arr = col.map{ |x| x.to_s }
    col_str = col_arr.join(', ')
    arr = ["?"] * col.length
    skr = arr.join(", ")
    dropped_av = attribute_values.drop(0)
    DBConnection.execute(<<-SQL, *dropped_av)
    INSERT INTO
      #{self.class.table_name} (#{col_str})
    VALUES
      (#{skr})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    table = self.class.table_name
    col = self.class.columns
    equals_q = col.map { |x| "#{x} = ?" }
    q_mark_strings = equals_q.join(', ')
    dropped_av = attribute_values.drop(0)
    DBConnection.execute(<<-SQL, *dropped_av, id)
    UPDATE
      #{self.class.table_name}
    SET
      #{q_mark_strings}
    WHERE
      #{table}.id = ?
    SQL
  end

  def save
    if self.id
      self.update
    else
      self.insert
    end
  end
end
