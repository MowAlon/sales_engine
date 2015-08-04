class DataInstance
  attr_reader :id, :repository, :created_at, :updated_at

  def initialize(attributes, repository)
    @repository = repository
    attributes.each do |name, value|
      instance_variable_set(to_instance_var(name), value)
    end
  end

  def all_referred_by search_repository
    search_repository.find_all_by(reference, id)
  end

  def referred_by search_repository
    search_repository.find_by(reference, id)
  end

  def to_instance_var variable
    "@#{variable}".to_sym
  end

  def reference
    "#{type_name}_id".to_sym
  end
end
