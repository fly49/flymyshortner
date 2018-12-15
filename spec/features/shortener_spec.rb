require 'rails_helper'
require 'sidekiq/testing'
require 'webmock/rspec'
Sidekiq::Testing.inline!

feature 'shortener' do
  let!(:stub) do
    stub_request(:any, web_url)
      .with(headers: {'Accept'=>'*/*','User-Agent'=>'Ruby'})
      .to_return(status: 200, body: "", headers: {'content-type' => 'text/html'})
  end
  let!(:rubocop_stub) do
    stub_request(:any, url_with_title)
      .with(headers: {'Accept'=>'*/*','User-Agent'=>'Ruby'})
      .to_return(status: 200, body: "<title>Home - RuboCop: The Ruby Linter that Serves and Protects</title>", headers: {'content-type' => 'text/html'})
  end
  
  before(:each) { visit root_path }
  let(:web_url) { 'https://bitly.com/' }
  let(:url_with_title) { 'https://rubocop.readthedocs.io/en/latest/' }
  
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
  
  scenario 'worker gets link title' do
    fill_in 'address', with: url_with_title
    click_button 'SHORTEN'
    visit current_path
    expect(page).to have_content('Home - RuboCop: The Ruby Linter that Serves and Protects')
  end
end