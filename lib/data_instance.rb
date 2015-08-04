class DataInstance
  attr_reader :id, :repository, :created_at, :updated_at

  def initialize(attributes, repository)
    @repository = repository
    attributes.each do |name, value|
      instance_variable_set(to_instance_var(name), value)
    end
  end

  def to_instance_var variable
    "@#{variable}".to_sym
  end
end
