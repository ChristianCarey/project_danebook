module LikablePresenter

  def first_and_other_likers
    if @object.likings_count && @object.likings.any?
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
    if @object.likings_count && @object.likings.any?
      likings_count = @object.likings.size
      verb = likings_count == 1 ? "likes" : "like"
      "#{pluralize(likings_count, 'person')} #{verb} this"
    end
  end

  def like_link
    if current_user.likes?(@object)
      # TODO can I get the right liking without making this query?
      liking = Liking.where(user_id: current_user.id, likable_id: @object.id).first
      path = "liking_path"
      link_to 'Unlike', send(path, liking.id), method: :delete
    else
      resource = @object.class.to_s.downcase
      path = "#{resource}_likings_path"
      link_to 'Like', send(path, @object), method: :post
    end
  end
end