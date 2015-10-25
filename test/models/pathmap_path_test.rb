require_relative "../test_helper"

describe Pathmap::Path do
  let(:orig) { Pathmap.root.join("test/data/orig/MT/tiff/MT0001/mt1.tif") }
  let(:scan) { Pathmap.root.join("test/data/scan/bol/MT/mt0001/mt1.jpg") }

  def test_orig_files_exist
    _(orig.exist?).must_equal true
  end

  def test_scan_file_exist
    _(scan.exist?).must_equal true
  end

  describe "root" do
    def test_root
      map = Pathmap.path(orig, root: "orig")
      _(map.root).must_equal Pathmap.root.join("test/data/orig")
    end
  end

  describe "path" do
    def test_path
      map = Pathmap.path(orig, root: "orig")
      _(map.path).must_equal Pathname("MT/tiff/MT0001/mt1.tif")
    end
  end
end