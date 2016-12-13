FactoryGirl.define do
  # TODO can I make this commentable as well as posts? ditto likable
  
  factory :comment do
    content "Lorem ipsum."
    author
    commentable
  end
end
