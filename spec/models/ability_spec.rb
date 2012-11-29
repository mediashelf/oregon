require "spec_helper"

describe Ability do
  describe "#user_groups" do
    before do
      @user = User.new
      @ability = Ability.new(@user)
    end

    it "should return the users groups and the default groups" do
      @user.should_receive(:groups).and_return(["group 1"])
      @ability.should_receive(:default_user_groups).and_return(["default"])
      @ability.instance_variable_set("@user_groups", nil)

      groups = @ability.user_groups(@user, {})
      groups.length.should == 2
      groups.should include("group 1", "default")
    end
  end
end
