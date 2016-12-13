FactoryGirl.define do
  factory :post, aliases: [:commentable, :likable] do
    content "Lorem ipsum."
    author
  end
end
