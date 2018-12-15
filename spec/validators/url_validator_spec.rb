require 'rails_helper'

describe UrlValidator do
  before(:each) do
    @validator = UrlValidator.new({:attributes => { foo: :bar }})
    @mock = double('model', errors: ActiveModel::Errors.new({}))
  end

  it "should validate valid address" do
    @validator.validate_each(@mock, "url", "https://github.com")
    expect(@mock.errors.messages).to be_empty
  end

  it "should validate invalid address" do
    @validator.validate_each(@mock, "url", "lol.kek")
    @validator.validate_each(@mock, "url", "invalid")
    expect(@mock.errors[:url].size).to eq 2
  end  
end