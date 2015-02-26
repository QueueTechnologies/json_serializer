module JSONSerializer
  autoload :ClassMethods,    "json_serializer/class_methods"
  autoload :InstanceMethods, "json_serializer/instance_methods"

  def self.included(base)
    base.send :extend,  ClassMethods
    base.send :include, InstanceMethods
  end
end
