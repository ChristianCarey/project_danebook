module LikablePresenter

  def first_and_other_likers
    if @object.likers.any?
      first = @object.likers.first
      first_link = link_to first.name, user_posts_path(first), class: 'underlined'
      remainder = @object.likers.count - 1
      if remainder == 0
        "#{first_link} likes this".html_safe
      else
        "#{first_link} and #{pluralize(remainder, 'other person')} like this".html_safe
      end
    end
  end

  def num_likers
    liker_count = @object.likers.count
    verb = liker_count == 1 ? "likes" : "like"
    "#{pluralize(liker_count, 'person')} #{verb} this" if @object.likers.any?
  end

  def comments
    if @object.comments.any?
      content_tag(:div, "<hr> #{render(@object.comments)}".html_safe, class: 'post-comments-container')
    end
  end
end