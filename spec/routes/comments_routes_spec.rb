# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'routing' do

    it do
      should route(:post, '/microposts/1/comments').to( controller: 'comments', action: 'create', micropost_id: '1')
    end

    it do
      should route(:delete, '/microposts/1/comments/1')
      .to( controller: 'comments', action: 'destroy', micropost_id: '1', id: '1')
    end
  end
end
