require "spec_helper"

describe Workflow do
  its(:needs_review?) {should be_true}

  its(:to_solr) {should == {"needs_review_s" => "true"}}

  context "when review is complete" do
    before do
      subject.review_process.status = "completed"
    end

    its(:needs_review?) {should be_false}
  end
end
