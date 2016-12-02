require 'spec_helper'

describe 'micropost', :js do

  context 'create micropost' do
    before { user_login }

    scenario 'create micropost from home page' do

     # page.execute_script <<-SCRIPT
     # $('iframe').html('<p>test</p>');
     # SCRIPT
     #  click_button 'Post'
      sleep(3)
    end
  end
end


