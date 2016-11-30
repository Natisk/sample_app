require 'spec_helper'

RSpec.describe RelationshipsController, :type => :controller do
  describe 'routing' do

    it do
      should route(:post, '/relationships').
          to( controller: 'relationships', action: 'create' )
    end

    it do
      should route(:delete, '/relationships/1').
          to( controller: 'relationships', action: 'destroy', id: '1' )
    end
  end
end
