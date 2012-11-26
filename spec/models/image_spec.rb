require 'spec_helper'

describe Image do
  before do
    @image = Image.new(:hasFormat => 'B&W print')
  end
  it "should have some Dublin Core terms" do
    @image.hasFormat.should == ["B&W print"]
  end
end
