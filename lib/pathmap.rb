require "bundler/setup"
require "pathmap/version"

module Pathmap
  require "pathmap/path"
  require "pathmap/map"
  require "pathmap/transpose"

  def self.root
    @@root ||= Pathname.new( File.expand_path("../../", __FILE__))
  end

  def self.path(*args)
    Pathmap::Path.new(*args)
  end

  def self.map(*args)
    Pathmap::Map.new(*args)
  end

  def self.trans(*args)
    Pathmap::Transpose.new(*args)
  end

end
