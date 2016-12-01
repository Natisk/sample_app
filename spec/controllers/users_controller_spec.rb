require 'spec_helper'

RSpec.describe UsersController, :type => :controller do
  before(:each) do
    User.new(id: 5, name: 'test', email: 'test@test.com', password: 'qwerty').save!
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

  context 'with user sign_in' do
    login_user

    describe 'GET #index' do
      before { get :index }

      it { should render_template('index') }
    end

    describe 'GET #show' do
      before { get :show, params: {id: '5'} }

      it { should render_template('show') }
    end

    describe 'GET #edit' do
      before { get :edit, params: {id: '5'} }

      it { should redirect_to(users_path) }
    end
  end

  context 'with admin sign_in' do
    login_admin

    describe 'GET #edit' do
      before { get :edit, params: {id: '5'} }

      it { should render_template('edit') }
    end
  end
end