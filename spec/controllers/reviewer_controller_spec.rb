require "spec_helper"

describe ReviewerController do
  describe "GET index / show" do
    before do
      Image.find_each {|img| img.delete}
      Image.all.length.should == 0
      @img = Image.new
      @img.save!
      Image.all.length.should == 1
    end

    context "(for a reviewer)" do
      before do
        User.any_instance.stub(:groups).and_return(["reviewer"])

        @user = User.new(:email => "fakey@example.com", :password => "s3krit!")
        @user.save!
        sign_in @user
      end

      it "should show the asset in GET :index" do
        get :index, :q => "", :search_field => "all_fields"
        response.should be_successful
        assigns(:document_list).size.should == 1
        assigns(:document_list).first.id.should == @img.pid
      end

      it "should show the asset in GET :show" do
        get :show, :id => @img.pid
        response.should be_successful
        assigns(:document).id.should == @img.pid
      end
    end

    context "(for a guest)" do
      it "should hide the asset in GET :index" do
        get :index, :q => "", :search_field => "all_fields"
        response.should_not be_successful
      end

      it "should hide the asset in GET :show" do
        get :show, :id => @img.pid
        response.should_not be_successful
      end
    end
  end
end
