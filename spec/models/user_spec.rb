require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    password = Faker::Internet.password
    @user = User.new email: Faker::Internet.email,
                     name: Faker::Name.first_name,
                     password: password,
                     password_confirmation: password
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'is invalid without password confirmation' do
    @user.password_confirmation = nil
    expect(@user).to be_invalid
  end

  it 'is invalid with insuffisant password' do
    password = Faker::Internet.password.first(5)

    @user.update password: password, password_confirmation: password
    expect(@user).to be_invalid
  end

  it 'is invalid without name' do
    @user.name = nil
    expect(@user).to be_invalid
  end

  it 'is invalid without email' do
    @user.email = nil
    expect(@user).to be_invalid
  end

  it 'is invalid with not uniq name' do
    @user.save
    password = Faker::Internet.password
    user = User.new  email: Faker::Internet.email,
                     name: @user.name,
                     password: password,
                     password_confirmation: password

    expect(user).to be_invalid
  end

  it 'is invalid with not uniq email' do
    @user.save
    password = Faker::Internet.password
    user = User.new  email: @user.email,
                     name: Faker::Name.first_name,
                     password: password,
                     password_confirmation: password

    expect(user).to be_invalid
  end

  it 'is valid with correct email' do
    @user.update email: 'example@example.com'
    expect(@user).to be_valid
  end

  it 'is invalid with incorrect email' do
    ['example@example', '@example.fr', 'example'].each do |email|
      @user.update email: email
      expect(@user).to be_invalid
    end
  end

  it 'is invalid with name with space' do
    @user.name = 'jules verne'
    expect(@user).to be_invalid
  end

  it 'downcase email' do
    @user.update! email: Faker::Internet.email.upcase
    expect(@user.email).to eq(@user.email.downcase)
  end
end
