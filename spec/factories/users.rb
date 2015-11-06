FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "gene_parmesan_#{n}@privateeye.biz" }
    password_digest 'password'
    authentication_token { SecureRandom.hex(20).encode('UTF-8') }
    authentication_token_expires_at { 30.days.from_now }
  end
end
