require_relative "../test_helper"


describe Pathmap::Map do

  let(:path) { Pathname.new("MT/tiff/MT0001/mt1.tif") }
  let(:names) { {folder: /\D++\d{4}$/, project: /^[A-Xing]{2,12}$/} }

  describe "name" do
    def test_name_with_regex
      map = Pathmap.map(path)
      _(map.name(/\D++\d{4}/)).must_equal "MT0001"
    end

    def test_name_with_regex2
      map = Pathmap.map(path)
      _(map.name(/^[A-Xing]{2,12}$/)).must_equal "MT"
    end
  end

  describe "call" do
    def test_call
      map = Pathmap.map(path, names: names)
      map.call
      _(map.folder).must_equal "MT0001"
      _(map.project).must_equal "MT"
    end

    def test_call2
      map = Pathmap.map(path, names: names)
      map.call
      _(map.attributes).must_equal(
        Hash({folder: "MT0001", project: "MT", file: "mt1.tif"}))
    end

    def test_call_reverse_names
      map2 = Pathmap.map(path, names: {project: /^[A-Xing]{2,12}$/, folder: /\D++\d{4}$/})
      map2.call
      _(map2.attributes[:folder]).must_equal nil
    end
  end

  describe "to_trans" do
    def test_transpose
      map = Pathmap.map(path, names: names)
      _(map.to_trans("/:a").class).must_equal Pathmap::Transpose
    end
  end
end

