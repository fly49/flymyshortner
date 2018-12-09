require 'rails_helper'

feature 'shortener' do
  before(:each) { visit root_path }
  let(:web_url) { 'https://bitly.com/' }
  let(:url_with_title) { 'https://rubocop.readthedocs.io/en/latest/' }
  
  # scenario 'warn about invalid url' do
  #   fill_in 'address', with: 'in.valid.url'
  #   click_button 'SHORTEN'
  #   expect(page).to have_content(I18n.t('link.invalid'))
  # end
  
  scenario 'shorten and redirect successfully' do
    fill_in 'address', with: web_url
    click_button 'SHORTEN'
    click_link 'short_link'
    expect(current_url).to eq web_url
  end
  
  scenario 'do not make duplicates' do
    fill_in 'address', with: web_url
    click_button 'SHORTEN'
    fill_in 'address', with: web_url
    click_button 'SHORTEN'
    all class: 'card', count: 1
  end
end