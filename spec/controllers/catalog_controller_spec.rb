require "spec_helper"

describe CatalogController do
  describe "GET index / show" do
    context "for a protected asset" do
      before do
        Image.find_each {|img| img.delete}
        @img = Image.new
        @img.read_groups = ["library"]
        @img.save!
      end

      context "(for a user with a special IP address)" do
        before do
          @user = User.new(:email => "fakey@example.com", :password => "s3krit!")
          @user.current_sign_in_ip = "128.223.223.89"
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

      context "(for a user without a special IP address)" do
        before do
          @user = User.new(:email => "fakey@example.com", :password => "s3krit!")
          @user.current_sign_in_ip = "127.0.0.1"
          @user.save!
          sign_in @user
        end

        it "should hide the asset in GET :index" do
          get :index, :q => "", :search_field => "all_fields"
          response.should be_successful
          assigns(:document_list).should == []
        end

        it "should hide the asset in GET :show" do
          get :show, :id => @img.pid
          response.should redirect_to(root_path)
          flash[:alert].should be_present
        end
      end
    end
  end
end
