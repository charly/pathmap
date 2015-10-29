module Pathmap
  class Transpose
    attr_reader :map, :template

    def initialize(map:, template: nil)
      @map      = map
      @template = template
      map.call
    end

    def nodes
      @nodes ||= Hash[
        template.split("/").map{|a| [a.gsub(/^:/, ""), get_value(a)] }]
    end

    def format(&block)
      block.call(nodes, map.attributes)
      return self
    end

    def to_path
      Pathname(nodes.values.join("/"))
    end

    def to_dir
      to_path.dirname
    end

    def to_s
      nodes.values.join("/")
    end

  private
    def get_value(key)
      (match = key[/(^:)(\w+)/, 2]) ? map.attributes[match.to_sym] : key
    end

  end
end
