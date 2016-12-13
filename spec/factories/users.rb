FactoryGirl.define do
  factory :user, aliases: [:author, :friend] do
    sequence :first_name do |n|
     "foo#{n}"
   end
    last_name  "bar"
    email      { "#{first_name}#{last_name}@baz.com" } 
    password   "password"
    password_confirmation "password"

    trait :short_password do 
      password "a" * 5
      password_confirmation "a" * 5
    end

    trait :mismatched_password do 
      password "password"
      password_confirmation "password1"
    end
  end
end
