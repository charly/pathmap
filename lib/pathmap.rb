require "pathmap/version"
require "pathmap/map"

module Pathmap

  def self.root
    @@root ||= Pathname.new( File.expand_path("../../", __FILE__))
  end

  def self.data_path=( string )
    @data_path = root.join(string)
  end

  def self.data_path
    @data_path or root.join("data")
  end

end