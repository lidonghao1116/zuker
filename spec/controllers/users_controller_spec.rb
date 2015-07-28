require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  render_views

  before :each do
    @user_1 = User.create(name: "peter1", phone_number: "0920085181", password: "123456")
    @user_1.generate_pin
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

  describe '沒登入' do

    before :each do
      session[:user_id] = nil
    end

    context 'GET #edit' do
      it "不能edit，會被轉到註冊頁面" do
        get :edit, id: @user_1[:id]
        expect(response).to have_http_status(302)
        expect(response).to redirect_to signup_users_path
        #expect(response).to render_template(:new)
      end
    end

    context 'GET #show' do
      it "不能show，會被轉到註冊頁面" do
        get :show, id: @user_1[:id]
        expect(response).to have_http_status(302)
        expect(response).to redirect_to signup_users_path
        #expect(response).to render_template(:new)
      end
    end

    context 'DELETE #destroy' do
      it "不能destroy，會被轉到註冊頁面" do
        delete :destroy, id: @user_1[:id]
        expect(response).to have_http_status(302)
        expect(response).to redirect_to signup_users_path
        #expect(response).to render_template(:new)
      end
    end

  end

  describe '成功登入' do

    before :each do
      session[:user_id] = @user_1.id
    end

    context 'GET #edit' do
      it "能edit" do
        get :edit, id: session[:user_id]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit)
      end
    end

    context 'GET #show' do
      it "能show" do
        get :show, id: session[:user_id]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show)
      end
    end

    context 'DELETE #destroy' do
      it "能destroy，會轉到users_url" do
        delete :destroy, id: session[:user_id]
        expect(response).to have_http_status(302)
        expect(response).to redirect_to users_url
      end
    end

  end

end
