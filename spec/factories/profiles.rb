FactoryGirl.define do
  factory :profile do
    user
    birthday Date.today - 10
    college "MyString"
    hometown "MyString"
    current_location "MyString"
    phone "MyString"
    about_me "MyText"
    tagline "MyText"
  end
end
