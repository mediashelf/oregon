require 'spec_helper'

describe Image do
  context "create from initializer" do
    before do
      @image = Image.new(:hasFormat => 'B&W print')
    end
    it "should have some Dublin Core terms" do
      @image.hasFormat.should == ["B&W print"]
    end
  end
  context "create from an Ntriples file then saved and the loaded" do
    before do
      image = Image.new
      path = fixture_path  + '/oregondigital_63.nt'
      image.descMetadata.content = File.open(path).read
      image.save
      @image = Image.find(image.pid)
    end
    it "should have many fields" do
      pending "The loaded content probably needs to be parsed (and assigned new subject)"
      @image.descMetadata.subject.should include("Agricultural laborers--Mexican--Oregon", "Agricultural laborers--Housing--Oregon")
    end
  end
end
