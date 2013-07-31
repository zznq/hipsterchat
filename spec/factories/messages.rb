# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    date '2010-11-19T15:48:19-0800'
    association :from, factory: :user
    message 'Boom Shaka Lacka'
  end
end
