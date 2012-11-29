require 'spec_helper'

describe User do
  subject do
    User.new(email: 'user1@example.com', password: 'foo')
  end
  it "should validate that the password is more than 6 characters" do
    subject.should_not be_valid
    subject.errors[:password].should == ["is too short (minimum is 6 characters)"]
  end

  describe "#groups" do
    context "(for a user without a special IP address)" do
      it "should include 'library'" do
        subject.current_sign_in_ip = "128.223.223.89"
        subject.groups.should include("library")
      end
    end

    context "(for a user without a special IP address)" do
      it "should not include 'library'" do
        subject.current_sign_in_ip = "28.223.223.89"
        subject.groups.should_not include("library")
      end
    end
  end
end
