FactoryGirl.define do
  factory :comment do
    content "MyText"
    author_id 1
    parent_id 1
  end
end
