# frozen_string_literal: true

require 'spec_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe 'GET #home' do
    before { get :home }
    it { should render_template('home') }
  end

  describe 'GET #about' do
    before { get :about }
    it { should render_template('about') }
  end
end