# frozen_string_literal: true

# Class fetched from another project
# Tweaked to use dry-effects and work with multiple databases
class BaseRepository
  include Dry::Effects.Resolve(:databases)

  def self.relations(*params, **args)
    params
      .each_with_object(args) { |param, rels| rels[param] = param }
      .then do |relations_mapping|
        relations_mapping.each do |method_name, relation_name|
          define_method(method_name) do
            @current_container.relations[relation_name]
          end
        end
      end
  end

  def self.commands(*params, **args)
    params
      .each_with_object(args) { |param, rels| rels[param] = param }
      .each do |method_name, command_name|
        define_method(method_name) { command_name }
      end
  end

  def initialize
    @containers = databases.each_with_object({}) { |db, acc| acc[db] = Spacinov::Container[db] }
    @current_container = @containers[databases.first]
  end

  def ==(other)
    self.class == other.class
  end

  def inspect
    "<#{self.class.name}>"
  end

  # == function
  #
  # :call-seq:
  #   function(type = ::ROM::Types::Any) -> ROM::SQL::Function
  # Simplifies the call to SQL functions in ROM.
  # When invoked, this method returns an instance of `::ROM::SQL::Function` with a specified type or a default of `::ROM::Types::Any`.
  # To make use of this function, call a method on the result object with the name of the SQL function you wish to use. The method name should be in lowercase, and it will be transformed into the corresponding uppercase SQL function name.
  #
  # === Examples
  #   function.foo
  #   # => FOO in SQL.
  #   function.coalesce(reports[:retailer_id], extractors[:retailer_id]).as(:retailer_id)
  #   # => COALESCE(reports.retailer_id, extractors.retailer_id) AS retailer_id in SQL.
  #
  # === Parameters
  # type :: Type of the function. Defaults to `::ROM::Types::Any`.
  #
  # === Returns
  # An instance of `::ROM::SQL::Function`.
  #
  # === Notes
  # This function serves as a shorthand for creating `ROM::SQL::Function` objects and helps improve readability in the codebase.
  def function(type = ::ROM::Types::Any)
    ::ROM::SQL::Function.new(type)
  end

  def for_all_containers
    @containers.each_pair.map do |db, container|
      @current_container = container
      yield(db).map { _1[:origin] = db; _1 }
    end
  end
end
