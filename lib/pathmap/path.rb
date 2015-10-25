module Pathmap
  class Path
    attr_reader :fullpath, :root, :path, :current_path, :names
    include Enumerable

    def initialize(fullpath, root: "/", names: {})
      @fullpath = fullpath
      @root     = find_root root
      @path     = fullpath.relative_path_from(@root)
      @names    = names
    end

  private
    def find_root(string)
      fullpath.to_enum(:descend)
              .detect{|p| p.basename.to_s == string}
    end
  end
end