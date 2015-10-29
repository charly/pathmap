module Pathmap
  class Map
    include Enumerable
    attr_reader :path, :names, :attributes, :current_path

    def initialize(path, names: {})
      @path = path
      @names = names
      @attributes = {file: "#{path.basename}"}
      @current_path = path
    end

    def file
      "#{path.basename}"
    end

    def each(&block)
      names.each(&block)
    end

    def name(regex)
      p = find(regex) and p.basename.to_s
    end

    def call
      each do |key, value|
        name = name(value)
        create_method(key) {name}
        attributes[key] = name
      end
    end

    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

    def to_trans(template)
      @transpose_to ||= Transpose.new(map: self, template: template)
    end


  private
    def find(regex, direction: :ascend)
      @current_path =  current_path
        .to_enum(direction)
          .detect {|p| p.basename.to_s.match regex}
    end
  end
end