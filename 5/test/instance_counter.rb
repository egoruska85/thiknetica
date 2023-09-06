module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@instance_hash, Hash.new(0))
  end

  module ClassMethods
    def instances
      self.class_variable_get(:@@instance_hash)[self.to_s]
    end

  end

  module InstanceMethods

    private

    def register
      src = self.class
      counter = self.class.class_variable_get(:@@instance_hash)
      counter[src.to_s] += 1
      self.class.class_variable_set(:@@instance_hash, counter)
    end

  end
end
