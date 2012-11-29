require 'spec_helper'

describe Collection do
  it "should have images" do
    c1 = Collection.create
    c2 = Collection.create
    img = Image.create

    img.collections.should == []

    img.collections << c1
    img.save

    c1 = Collection.find(c1.pid)
    c1.images.should == [img]

    img.collections << c2
    img.save

    img = Image.find(img.pid)
    img.collections.should include(c1, c2)
    img.collections.length.should == 2
  end
end
