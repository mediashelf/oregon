require 'spec_helper'

describe Image do
  context "create from initializer" do
    before do
      @image = Image.new(:hasFormat => 'B&W print')
    end
    it "should have some Dublin Core terms" do
      @image.hasFormat.should == ["B&W print"]
    end
    it "should have a content datastream" do
      @image.content.should be_kind_of(ActiveFedora::Datastream)
    end
    it "should have a thumbnail datastream" do
      @image.thumbnail.should be_kind_of(ActiveFedora::Datastream)
    end
    it "should have right data" do
      @image.rightsMetadata.should be_kind_of(Hydra::Datastream::RightsMetadata)
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

  describe "#to_solr" do
    before do
      @img = Image.new
      @img.save
    end

    context "on an unreviewed image" do
      it "should index needs_review_s as true" do
        @img.to_solr["needs_review_s"].should == "true"
      end
    end

    context "on a reviewed image" do
      it "should index needs_review_s as false" do
        @img.workflowMetadata.review_process.status = "completed"
        @img.to_solr["needs_review_s"].should == "false"
      end
    end
  end

  describe "#review!" do
    it "should complete the review process" do
      @img = Image.new
      answer = ["completed"]
      @img.workflowMetadata.review_process.status.should_not == answer
      @img.review!
      @img.workflowMetadata.review_process.status.should == answer
    end

    it "should become public" do
      @img = Image.new
      @img.read_groups.should == []
      @img.review!
      @img.read_groups.should == ["public"]
    end
  end
end
