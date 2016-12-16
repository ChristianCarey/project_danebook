module LikablePresenter

  def first_and_other_likers
    if likable.likings_count && likable.likings.any?
      first = likable.likers.first
      first_link = link_to first.name, user_activities_path(first), class: 'underlined'
      remainder = likable.likings.size - 1
      if remainder == 0
        "#{first_link} likes this".html_safe
      else
        "#{first_link} and #{pluralize(remainder, 'other person')} like this".html_safe
      end
    end
  end

  def num_likings
    if likable.likings_count && likable.likings.any?
      likings_count = likable.likings.size
      verb = likings_count == 1 ? "likes" : "like"
      "#{pluralize(likings_count, 'person')} #{verb} this"
    end
  end

  def like_link
    if current_user.likes?(likable)
      # TODO can I get the right liking without making this query?
      liking = Liking.where(user_id: current_user.id, likable_id: likable.id).first
      path = "liking_path"
      link_to 'Unlike', send(path, liking.id), class: 'like-link', method: :delete
    else
      resource = likable.class.to_s.downcase
      path = "#{resource}_likings_path"
      link_to 'Like', send(path, likable), class: 'like-link', method: :post
    end
  end

  private

  def likable
    @object
  end
end