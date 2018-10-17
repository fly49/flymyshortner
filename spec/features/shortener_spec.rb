require 'rails_helper'

feature 'shortener' do
  before(:each) { visit root_path }
  let(:web_url) { 'https://bitly.com/' }
  
  scenario 'warn about invalid url' do
    fill_in 'address', with: 'in.valid.url'
    click_button 'SHORTEN'
    expect(page).to have_content(I18n.t('link.invalid'))
  end
  
  scenario 'shorten and redirect successfully' do
    fill_in 'address', with: web_url
    click_button 'SHORTEN'
    click_link 'shortened_link'
    expect(current_url).to eq web_url
  end
end