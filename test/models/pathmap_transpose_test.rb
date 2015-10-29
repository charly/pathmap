require_relative "../test_helper"

describe Pathmap::Transpose do

  let(:map) do
    Pathmap.map(Pathname.new("MT/tiff/MT0001/mt1.tif"),
                names: {folder: /\D++\d{4}$/, project: /^[A-Zing]{2,12}$/})
  end

  describe "nodes" do
    def test_nodes
      trans = map.to_trans(":project/jpeg/:folder/:file")
      _(trans.nodes).must_equal Hash(
        {"project"=>"MT", "jpeg"=>"jpeg", "folder"=>"MT0001", "file"=>"mt1.tif"})
    end


    def test_nodes_with_missing_map_attr
      trans = map.to_trans(":project/jpeg/:file")
      _(trans.nodes).must_equal Hash(
        {"project"=>"MT", "jpeg"=>"jpeg", "file"=>"mt1.tif"})
    end
  end

  describe "format" do
    def test_format
      trans = map.to_trans(":project/jpeg/:folder/:file")
      trans.format do |attr|
        attr["folder"] = attr["folder"].downcase
      end

      _(trans.nodes["folder"]).must_equal "mt0001"
    end

    def test_format_renaming
      trans = map.to_trans(":project/:file").format do |attr, mattr|
        attr["file"] = "#{mattr[:folder].downcase}_#{attr['file']}"
      end

      _(trans.nodes["file"]).must_equal "mt0001_mt1.tif"
    end

  end
end
