class DataInstance
  attr_reader :id, :repository, :type_name, :created_at, :updated_at

  def initialize(attributes, repository, type_name)
    @repository = repository
    attributes.each do |name, value|
      instance_variable_set(to_instance_var(name), value)
    end
    @type_name = type_name
  end

  def to_instance_var variable
    "@#{variable}".to_sym
  end
end
