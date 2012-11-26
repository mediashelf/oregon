require 'spec_helper'

describe User do
  subject do
    User.new(email: 'user1@example.com', password: 'foo')
  end
  it "should validate that the password is more than 6 characters" do
    subject.should_not be_valid
    subject.errors[:password].should == ["is too short (minimum is 6 characters)"]
  end
end
