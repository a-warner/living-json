require 'json'

class LivingJson
  
  def initialize(collection={})
    @underlying = collection
  end

  def self.from(source)
    LivingJson.new(source.is_a?(String) ? JSON.parse(source) : source)
  end

  def method_missing(method, *args, &block)
    if @underlying.respond_to?(method)
      @underlying.send(method, *args, &block)
    else 
      property = method.to_s.end_with?('=') ? method.to_s.gsub(/=$/,'') : method.to_s
      self.class.instance_eval do
        define_method property do 
          @underlying[property].is_a?(Hash) ? LivingJson.from(@underlying[property]) : @underlying[property]
        end
        define_method "#{property}=" do |new_value|
          @underlying[property] = new_value
        end
      end
      send(method, *args, &block)
    end
  end

  # right now someone could assign or fetch any property, so it responds to every method call
  def respond_to?(method)
    true
  end

  def to_json(*args)
    @underlying.to_json(*args)
  end

  def to_s
    to_json
  end
end
