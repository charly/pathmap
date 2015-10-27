module Pathmap
  class Map
    include Enumerable
    attr_reader :path, :names, :attributes, :current_path

    def initialize(path, names: {})
      @path = path
      @names = names
      @attributes = {file: "#{path.basename}"}
      create_method(:file) {"#{path.basename}"}
    end

    def each(&block)
      names.each(&block)
    end

    def name(regex)
      @current_path = find(regex)
      cp = @current_path and cp.basename.to_s
    end

    def call
      each do |key, value|
        create_method(key) {name(value)}
        attributes[key] = name(value)
      end
    end

    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

  private
    def find(regex, direction: :ascend)
      path.
        to_enum(direction).
        detect{|p| p.basename.to_s.match regex}
    end
  end
end