module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      method_values = []

      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        method_values << value
      end
      define_method("#{name}_history".to_sym) { method_values }
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise "Неверный тип!" unless value.is_a? type
      instance_variable_set(var_name, value)
    end
  end
end

class Test
  extend Accessors
end
