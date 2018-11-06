# Passive Documentation


## Description

Passive Documentation is a brief homemade sample of ActiveRecord::Base.
It can be used with SQL to perform some of the more simple data manipulations found in ActiveRecord.  

## Easy Usage

In this document there is a classes.rb file containing three classes, each of which is connected to a data table. By loading the classes.rb file into pry, the data in the three tables can be queried and manipulated using the PassiveDocumentation interface.  

## Features

Many of the common ActiveRecord methods are available, such as: #create, #update, #all, and #find.  

Here is an example of the #all method:
```
def self.all
  todos = DBConnection.execute(<<-SQL)
  SELECT
    *
  FROM
    #{self.table_name}
  SQL
  todos.map { |hash| self.new(hash) }
end
```

Some rails associations are also available here, including: has_many, belongs_to, and has_one_through.

Here is an example of the belongs_to method:

```
class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @class_name = options[:class_name] || "#{name}".camelcase
  end
end
```
