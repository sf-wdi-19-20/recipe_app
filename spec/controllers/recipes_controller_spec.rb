require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  # before do
  #   user_params = Hash.new
  #   user_params[:first_name] = FFaker::Name.first_name
  #   user_params[:last_name] = FFaker::Name.last_name
  #   user_params[:email] = FFaker::Internet.email
  #   user_params[:password] = FFaker::Lorem.words(2).join
  #   current_user = User.create(user_params)
  #   session[:user_id] = current_user.id
  # end

  before do
    current_user = FactoryGirl.create(:user)
    session[:user_id] = current_user.id
  end

  describe "#new" do
    before do
      get :new
    end

    it "should respond with 200 success" do
      expect(response.status).to be(200)
    end

    it "should assign @recipe" do
      expect(assigns(:recipe)).to be_instance_of(Recipe)
    end

    it "should render the :new view" do
      expect(response).to render_template(:new)
    end
  end

end