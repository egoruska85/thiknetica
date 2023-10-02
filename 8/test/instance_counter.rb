# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@instance_hash, Hash.new(0))
  end

  module ClassMethods
    def instances
      class_variable_get(:@@instance_hash)[to_s]
    end
  end

  module InstanceMethods
    private

    def register_instance
      src = self.class
      counter = self.class.class_variable_get(:@@instance_hash)
      counter[src.to_s] += 1
      self.class.class_variable_set(:@@instance_hash, counter)
    end
  end
end
