require 'spec_helper'

describe StaticPagesController do

  context 'GET #home' do

    it 'render #home if sign_in nil' do
      sign_in nil
      get :home
      expect(response).to render_template(:home)
    end

    login_user

    it 'render #home if sign_in' do
      get :home
      expect(response).to render_template(:home)
    end

  end

  context 'GET #about' do

    it 'render #about if sign_in nil' do
      sign_in nil
      get :about
      expect(response).to render_template(:about)
    end
  end
end