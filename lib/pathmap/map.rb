module Pathmap
  class Map
    attr_reader :fullpath, :root, :path, :current_path, :names
    include Enumerable

    def initialize(fullpath, root: "/", names: {})
      @fullpath  = fullpath
      @root      = find_root root
      @path      = fullpath.relative_path_from(@root)
      @names     = names
    end


    def each(&block)
      @names.each(&block)
    end

    def name(regex)
      @current_path = find(regex)
      r = current_path and r.basename.to_s
    end

    def call
      map do |key, value|
        create_method(key) {name(value)}
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

    def find_root(string)
      fullpath.to_enum(:descend).detect{|p| p.basename.to_s == string}
    end


  end
end