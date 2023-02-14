module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, validation_type, expression = nil)
      @validations ||= []
      @validations << [name, validation_type, expression]
    end

    def presense(name)
      'Пустое значение атрибута!' if name.nil? || name.to_s.strip.empty?
    end

    def format(name, expression)
      'Значение атрибута не соответствует регулярному выражению!' unless name.match(expression)
    end

    def type(name, expression)
      'Атрибут не соответствует классу!' unless name.is_a? expression
    end
  end

  module InstanceMethods

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate!
      errors = []
      self.class.validations.each do | name, type, expression |
        var_name = "@#{name}"
        case type
        when :presense
          errors << self.class.presense(instance_variable_get(var_name))
        when :format
          errors << self.class.format(instance_variable_get(var_name), expression)
        when :type
          errors << self.class.type(instance_variable_get(var_name), expression)
        end
      end
      raise puts errors.compact if errors.any?
    end

  end
end
