require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before :each do
    @user_1 = User.create(name: "peter1", phone_number: "0920085181", password: "123456")
  end

  it "#index" do
    get :index
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  it "#new" do
    get :new
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  describe 'without login' do

    render_views

    it "沒登入不能edit，會被轉到註冊頁面" do
      get :edit, id: @user_1[:id]
      expect(response).to have_http_status(302)
      expect(response).to redirect_to signup_users_path
      expect(response).to render_template(:new)
    end

    it "沒登入不能show，會被轉到註冊頁面" do
      get :show, id: @user_1[:id]
      expect(response).to have_http_status(302)
      expect(response).to redirect_to signup_users_path
      #expect(response).to render_template(:new)
    end

    it "沒登入不能destroy，會被轉到註冊頁面" do
      delete :destroy, id: @user_1[:id]
      expect(response).to have_http_status(302)
      expect(response).to redirect_to signup_users_path
      #expect(response).to render_template(:new)
    end

  end
end
