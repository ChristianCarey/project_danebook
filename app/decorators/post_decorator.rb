class PostDecorator < Draper::Decorator
  delegate_all

  def delete_link
    '<li class="delete-post"><a href="#">Delete</a></li>'.html_safe if h.current_user == author
  end

  def first_and_other_likers
    if likers.any?
      first = likers.first
      remainder = likers.count - 1
      if remainder = 0
        "#{first.name} likes this"
      else
        "#{first.name} and #{pluralize(remainder, 'other person')} like this"
      end
    end
  end
end
