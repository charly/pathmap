require_relative "../test_helper"

describe Pathmap::Transpose do

  def path
    Pathname.new("MT/tiff/MT0001/mt1.tif")
  end

  def names
    {folder: /\D++\d{4}$/, project: /^[A-Xing]{2,12}$/}
  end

  let(:trans) do
    trans = Pathmap.trans( map: Pathmap.map(path, names: names),
                           template: ":project/jpeg/:folder/:file")
  end

  describe "attributes" do
    def test_attributes
      _(trans.attributes).must_equal Hash(
        {"project"=>"MT", "jpeg"=>"jpeg", "folder"=>"MT0001", "file"=>"mt1.tif"})
    end
  end

  describe "format" do
    def test_template
      trans.format do |attr|
        attr["folder"] = attr["folder"].downcase
      end

      _(trans.attributes["folder"]).must_equal "mt0001"
    end
  end
end
