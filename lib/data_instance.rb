class DataInstance
  attr_reader :id, :repository, :created_at, :updated_at

  def initialize(attributes, repository)
    @repository = repository
    attributes.each do |name, value|
      instance_variable_set(to_instance_var(name), value)
    end
  end

  def refers_to search_repository
    search_repository.find_by(:id, send(search_repository.child_reference))
  end

  def all_referred_by search_repository
    search_repository.find_all_by(reference, id)
  end

  def referred_by search_repository
    search_repository.find_by(reference, id)
  end

  def sales_engine
    repository.sales_engine
  end

  def to_instance_var variable
    "@#{variable}".to_sym
  end

  def reference
    "#{type_name.to_s}_id".to_sym
  end
end
