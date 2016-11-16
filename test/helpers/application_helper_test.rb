require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test 'full title helper' do
    assert_equal full_title,         'Fox on Rails'
    assert_equal full_title('Help'), 'Help | Fox on Rails'
  end
end