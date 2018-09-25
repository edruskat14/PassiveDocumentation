Passive Documentation

Passive Documentation is a brief homemade sample of ActiveRecord::Base.
It can be used with SQL to perform some of the more simple data manipulations found in ActiveRecord.

In this document there is a classes.rb file containing three classes, each of which is connected to a data table. By loading the classes.rb file into pry, the data in the three tables can be queried and manipulated using the PassiveDocumentation interface.

Many of the common ActiveRecord methods are available, such as: #create, #update, #all, and #find.

Some rails associations are also available here, including: has_many, belongs_to, and has_one_through.
