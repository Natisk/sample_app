require 'spec_helper'

RSpec.describe StaticPagesController, :type => :controller do
  describe 'routing' do

    it do
      should route(:get, '/about').
          to( controller: 'static_pages', action: 'about' )
    end

    it do
      should route(:get, '/').
          to( controller: 'static_pages', action: 'home' )
    end
  end
end
