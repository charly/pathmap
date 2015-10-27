module Pathmap
  class Transpose
    attr_reader :map, :template

    def initialize(map:, template: nil)
      @map      = map
      @template = template
      map.call
    end

    def attributes
      @attributes ||= Hash[
        template.split("/").map{|a| [a.gsub(/^:/, ""), get_value(a)] }]
    end

    def format(&block)
      block.call(attributes)
    end


    def call
      binding.pry
    end

  private
    def get_value(key)
      (name = key.gsub!(/^:/, "")) ? map.send(name.to_sym) : key
    end

  end
end