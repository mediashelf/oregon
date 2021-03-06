require 'spec_helper'

describe OregonRDFDatastream do
  context "create from an Ntriples file" do
    before do
      @ds = OregonRDFDatastream.new(nil, nil)
      path = fixture_path  + '/oregondigital_63.nt'
      @ds.content = File.open(path).read
    end
    it "should have many fields" do
      @ds.subject.should include("Agricultural laborers--Mexican--Oregon", "Agricultural laborers--Housing--Oregon")
    end
    it "should support some PREMIS metadata" do
      @ds.preservation.should include("P0120_2570")
    end
  end

  
end
