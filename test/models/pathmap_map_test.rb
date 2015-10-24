require_relative "../test_helper"

describe Pathmap::Map do
  let(:orig) { Pathmap.root.join("test/data/orig/MT/tiff/MT0001/mt1.tif") }
  let(:scan) { Pathmap.root.join("test/data/scan/bol/MT/mt0001/mt1.jpg") }

  def test_files_exist
    _(orig.exist?).must_equal true
    _(scan.exist?).must_equal true
  end

  describe "root" do
    def test_root
      map = Pathmap::Map.new(orig, root: "orig")
      _(map.root).must_equal Pathmap.root.join("test/data/orig")
    end
  end

  describe "path" do
    def test_path
      map = Pathmap::Map.new(orig, root: "orig")
      _(map.path).must_equal Pathname("MT/tiff/MT0001/mt1.tif")
    end
  end

  describe "name" do
    def test_name_with_regex
      map = Pathmap::Map.new(orig, root: "orig")
      _(map.name(/\D++\d{4}/)).must_equal "MT0001"
    end

    def test_name_with_regex2
      map = Pathmap::Map.new(orig, root: "orig")
      _(map.name(/^[A-Xing]{2,12}$/)).must_equal "MT"
    end
  end

  describe "call" do
    def test_call
      names = {folder: /\D++\d{4}$/, project: /^[A-Xing]{2,12}$/}
      map = Pathmap::Map.new(orig, root: "orig", names: names)
      map.call
      _(map.folder).must_equal "MT0001"
      _(map.project).must_equal "MT"
    end
  end


//




end