FactoryGirl.define do
  factory :profile do
    user
    birthday "2016-12-07"
    college "MyString"
    hometown "MyString"
    current_location "MyString"
    phone "MyString"
    about_me "MyText"
    tagline "MyText"
  end
end
