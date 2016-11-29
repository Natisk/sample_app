require 'spec_helper'

describe StaticPagesController do

  before :each do
    sign_in nil
  end

  context 'GET #home' do

    it 'render #home' do
      get :home
      expect(response).to render_template(:home)
    end

  end

  context 'GET #about' do

    it 'render #about' do
      get :about
      expect(response).to render_template(:about)
    end

  end
end