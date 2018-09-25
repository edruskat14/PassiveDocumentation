require_relative 'associatable_a'

module Associatable

  def has_one_through(name, through_name, source_name)
    define_method(name) do

      through_options = self.class. assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      through_table = through_options.table_name
      desired_table = source_options.table_name

      desired_primary = source_options.primary_key
      through_primary = through_options.primary_key

      desired_foreign = source_options.foreign_key
      through_foreign = through_options.foreign_key

      val_final = self.send(through_foreign)
      found = DBConnection.execute(<<-SQL, val_final)
      SELECT
        #{desired_table}.*
      FROM
        #{through_table}
      JOIN
        #{desired_table}
        ON #{desired_table}.#{desired_primary} = #{through_table}.#{desired_foreign}
      WHERE
        #{through_table}.#{through_primary} = ?
      SQL
      source_options.model_class.parse_all(found).first
    end
  end
end
