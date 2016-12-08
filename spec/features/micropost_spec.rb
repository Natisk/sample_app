require 'spec_helper'

describe 'micropost' do

  context 'create micropost' do
    before { user_login }

    scenario 'create micropost from home page' do
      within('#new_micropost') do
        fill_in ('micropost[content]'), with: 'test post'
      end
      click_button 'Post'
      within('.microposts') do
        expect(page).to have_content @user.name
        expect(page).to have_content 'test post'
      end
    end
  end

  context 'edit and delete micropost' do
    before { user_login }
    let!(:micropost) { FactoryGirl.create(:micropost, user: @user) }

    scenario 'edit micropost' do
      sleep(1)
      visit root_path
      within "#micropost-#{micropost.id}" do
        find('.glyphicon-pencil').click
      end
      fill_in ('micropost[content]'), with: 'test content'
      click_button 'Save'
      expect(page).to have_content 'test content'
      expect(page).to have_content 'Post updated'
    end

    scenario 'delete micropost', :js do
      within "#micropost-#{micropost.id}" do
        find('.glyphicon-remove').click
      end
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      expect(page).to have_content 'Micropost deleted'
      expect(page).not_to have_content micropost
    end
  end

  context 'edit and delete micropost by admin' do
    before { admin_login }
    let(:user) { FactoryGirl.create(:user) }
    let!(:micropost) { FactoryGirl.create(:micropost, user: user) }

    scenario 'edit micropost' do
      visit abyss_path
      within "#micropost-#{micropost.id}" do
        find('.glyphicon-pencil').click
      end
      fill_in ('micropost[content]'), with: 'test content'
      click_button 'Save'
      expect(page).to have_content 'test content'
      expect(page).to have_content 'Post updated'
    end

    scenario 'delete micropost', :js do
      sleep(1)
      visit abyss_path
      sleep(1)
      within "#micropost-#{micropost.id}" do
        find('.glyphicon-remove').click
      end
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      expect(page).to have_content 'Micropost deleted'
      expect(page).not_to have_content micropost
    end
  end

  context 'edit and delete micropost by moderator' do
    before { moderator_login }
    let(:user) { FactoryGirl.create(:user) }
    let!(:micropost) { FactoryGirl.create(:micropost, user: user) }

    scenario 'edit micropost' do
      sleep(1)
      visit abyss_path
      within "#micropost-#{micropost.id}" do
        find('.glyphicon-pencil').click
      end
      fill_in ('micropost[content]'), with: 'test content'
      click_button 'Save'
      expect(page).to have_content 'test content'
      expect(page).to have_content 'Post updated'
    end

    scenario 'delete micropost', :js do
      sleep(1)
      visit abyss_path
      sleep(1)
      within "#micropost-#{micropost.id}" do
        find('.glyphicon-remove').click
      end
      page.driver.browser.switch_to.alert.accept
      sleep(1)
      expect(page).to have_content 'Micropost deleted'
      expect(page).not_to have_content micropost
    end
  end
end


