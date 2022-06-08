#require 'rails_helper'

FactoryGirl.define do
  factory :user do
     sequence(:email) { |n| "user#{n}@example.com" }
     password '123456'
     password_confirmation '123456'
     confirmed_at Date.today

  end

  factory :book do
    title "new"
    description "sam"
    author "ad"
    association :category
  end

  factory :category do
    name "ap"
  end
end