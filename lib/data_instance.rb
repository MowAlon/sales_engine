class DataInstance
  attr_reader :id, :repository, :created, :updated

  def to_instance_var variable
    "@#{variable}".to_sym
  end
end
