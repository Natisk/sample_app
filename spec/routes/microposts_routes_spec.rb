require 'spec_helper'

RSpec.describe MicropostsController, type: :controller do
  describe 'routing' do

    it do
      should route(:get, '/abyss').
          to( controller: 'microposts', action: 'index' )
    end

    it do
      should route(:post, '/microposts/1/like').
          to( controller: 'microposts', action: 'like_post', micropost_id: '1' )
    end

    it do
      should route(:post, '/microposts/1/dislike').
          to( controller: 'microposts', action: 'dislike_post', micropost_id: '1' )
    end

    it do
      should route(:post, '/microposts').
          to( controller: 'microposts', action: 'create' )
    end

    it do
      should route(:get, '/microposts/1/edit').
          to( controller: 'microposts', action: 'edit', id: '1' )
    end

    it do
      should route(:patch, '/microposts/1').
          to( controller: 'microposts', action: 'update', id: '1' )
    end

    it do
      should route(:put, '/microposts/1').
          to( controller: 'microposts', action: 'update', id: '1' )
    end

    it do
      should route(:delete, '/microposts/1').
          to( controller: 'microposts', action: 'destroy', id: '1' )
    end
  end
end

