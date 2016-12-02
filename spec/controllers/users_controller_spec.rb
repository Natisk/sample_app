require 'spec_helper'

RSpec.describe UsersController, :type => :controller do
  before(:each) do
    @user = create(:user)
    @user5 = create(:user, id: 15)
    @admin = create(:admin)
  end

  context 'with user sign_in nil' do

    describe 'GET #index' do
      before { get :index }

      it { should redirect_to(new_user_session_path) }
    end

    describe 'GET #edit' do
      before { get :edit, params: {id: '1'} }

      it { should redirect_to(new_user_session_path) }
    end
  end

  context 'with sign in user' do
    before(:each) do
      sign_in @user
    end

    describe 'GET #index' do
      before { get :index }

      it { should render_template('index') }
    end

    describe 'GET #show' do
      before { get :show, params: {id: '15'} }

      it { should render_template('show') }
    end

    describe 'GET #edit' do
      before { get :edit, params: {id: '15'} }

      it { should redirect_to(users_path) }
    end
  end

  context 'with admin sign_in' do
    before(:each) do
      sign_in @admin
    end

    describe 'GET #edit' do
      before { get :edit, params: {id: '15'} }

      it { should render_template('edit') }
    end
  end
end