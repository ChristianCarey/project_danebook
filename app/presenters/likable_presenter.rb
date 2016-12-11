module LikablePresenter

  def first_and_other_likers
    if @object.likings.any?
      first = @object.likers.first
      first_link = link_to first.name, user_posts_path(first), class: 'underlined'
      remainder = @object.likings.size - 1
      if remainder == 0
        "#{first_link} likes this".html_safe
      else
        "#{first_link} and #{pluralize(remainder, 'other person')} like this".html_safe
      end
    end
  end

  def num_likings
    if @object.likings_count
      likings_count = @object.likings.size
      verb = likings_count == 1 ? "likes" : "like"
      "#{pluralize(likings_count, 'person')} #{verb} this" 
    end
  end
end