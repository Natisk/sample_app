require 'spec_helper'

RSpec.describe UsersController, :type => :controller do
  describe 'routing' do

    it do
      should route(:get, '/users').
          to( controller: 'users', action: 'index' )
    end

    it do
      should route(:get, '/users/1/following').
          to( controller: 'users', action: 'following', id: '1' )
    end

    it do
      should route(:get, '/users/1/followers').
          to( controller: 'users', action: 'followers', id: '1' )
    end

    it do
      should route(:get, '/users/1/edit').
          to( controller: 'users', action: 'edit', id: '1' )
    end

    it do
      should route(:get, '/users/1').
          to( controller: 'users', action: 'show', id: '1' )
    end

    it do
      should route(:patch, '/users/1').
          to( controller: 'users', action: 'update', id: '1' )
    end

    it do
      should route(:put, '/users/1').
          to( controller: 'users', action: 'update', id: '1' )
    end

    it do
      should route(:delete, '/users/1').
          to( controller: 'users', action: 'destroy', id: '1' )
    end
  end
end

