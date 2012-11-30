require "spec_helper"

describe Ability do
  before do
    @user = User.new
  end

  describe "#user_groups" do
    before do
      @ability = Ability.new(@user)
    end

    it "should return the users groups and the default groups" do
      @user.should_receive(:groups).and_return(["group 1"])
      @ability.should_receive(:default_user_groups).and_return(["default"])
      @ability.instance_variable_set("@user_groups", nil)

      groups = @ability.user_groups
      groups.length.should == 2
      groups.should include("group 1", "default")
    end
  end

  describe "#custom_permissions" do
    context "for a reviewer" do
      it "should give permissions to review images" do
        @user.stub(:groups).and_return(["reviewer"])
        @ability = Ability.new(@user)
        @ability.can?(:review, Image).should be_true
      end
    end

    context "for a guest" do
      it "should not allow reviewing images" do
        @user.stub(:groups).and_return([])
        @ability = Ability.new(@user)
        @ability.can?(:review, Image).should be_false
      end
    end
  end
end
