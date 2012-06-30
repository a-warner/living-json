require 'json'

class LivingJson
  
  def initialize(collection)
    @underlying = collection
  end

  def self.from(source)
    LivingJson.new(source.is_a?(String) ? JSON.parse(source) : source)
  end

  def method_missing(method, *args, &block)
    if !self.class.method_defined?(method)
      property = method.to_s.end_with?('=') ? method.to_s.gsub(/=$/,'') : method.to_s
      self.class.instance_eval do
        define_method property do 
          @underlying[property]
        end
        define_method "#{property}=" do |new_value|
          @underlying[property] = new_value
        end
      end
      send(method, *args, &block)
    else
      super
    end
  end
end
