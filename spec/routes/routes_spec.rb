require 'spec_helper'

RSpec.describe StaticPagesController, :type => :controller do
  describe 'routing' do

  it 'routes /about to static_pages#about' do
    expect(get: '/about').to route_to( controller: 'static_pages', action: 'about' )
  end

  it 'routes / to static_pages#home' do
    expect(get: '/').to route_to( controller: 'static_pages', action: 'home' )
  end

  end
end
