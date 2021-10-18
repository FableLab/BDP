require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid with valid attributes' do
    user = User.new email: Faker::Internet.email,
                     name: Faker::Name.first_name,
                     password: Faker::Internet.password
    expect(user).to be_valid
  end

  it 'is invalid with insuffisant password' do
    user = User.new email: Faker::Internet.email,
                    name: Faker::Name.first_name,
                    password: Faker::Internet.password.first(5)
    expect(user).to be_invalid
  end

  it 'is invalid without name' do
    user = User.new email: Faker::Internet.email, password: Faker::Internet.password
    expect(user).to be_invalid
  end

  it 'is invalid with not uniq name' do
    name = Faker::Name.first_name
    User.create email: Faker::Internet.email, name: name, password: Faker::Internet.password
    user = User.new email: Faker::Internet.email, name: name, password: Faker::Internet.password
    expect(user).to be_invalid
  end

  it 'is invalid without email' do
    user = User.new name: Faker::Name.first_name, password: Faker::Internet.password
    expect(user).to be_invalid
  end

  it 'is invalid with not uniq email' do
    email = Faker::Internet.email
    User.create email: email, name: Faker::Name.first_name, password: Faker::Internet.password
    user = User.new email: email, name: Faker::Name.first_name, password: Faker::Internet.password
    expect(user).to be_invalid
  end

  it 'is invalid with incorrect email' do
    ['example@example', '@example.fr', 'example'].each do |email|
      user = User.new email: email, name: Faker::Name.first_name, password: Faker::Internet.password
      expect(user).to be_invalid
    end
  end

  it 'is invalid with name with space' do
    user = User.new email: Faker::Internet.email, name: Faker::Name.name, password: Faker::Internet.password
    expect(user).to be_invalid
  end

  it 'downcase email' do
    email = Faker::Internet.email.downcase
    user = User.create email: email.upcase, name: Faker::Name.first_name, password: Faker::Internet.password
    expect(user.email).to eq(email)
  end
end
