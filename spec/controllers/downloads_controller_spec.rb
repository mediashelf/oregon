require "spec_helper"

describe DownloadsController do
  it "should route" do
    {:get => "/downloads/changeme:1"}.should route_to(controller: "downloads", action: "show", id: "changeme:1")
  end

  describe "GET show" do
    before do
      @image = Image.new
      @image.add_file_datastream(File.open(fixture_path + "/P0120_2567.jpg", "rb").read,
          dsid: "thumbnail", mimeType: "image/jpeg", label: "P0120_2567.jpg")
      @image.save
    end

    it "should give us the thumbnail" do
      get :show, :id => @image.pid
      response.should be_successful
      response.body.should == File.open(fixture_path + "/P0120_2567.jpg", "rb").read
    end
  end
end
