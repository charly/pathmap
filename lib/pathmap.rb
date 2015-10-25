require "bundler/setup"
require "pathmap/version"

module Pathmap
  require "pathmap/path"
  require "pathmap/map"

  def self.root
    @@root ||= Pathname.new( File.expand_path("../../", __FILE__))
  end

  def self.data_path=( string )
    @data_path = root.join(string)
  end

  def self.data_path
    @data_path or root.join("data")
  end

  def self.path(*args)
    Pathmap::Path.new(*args)
  end

  def self.map(*args)
    Pathmap::Map.new(*args)
  end

end
