module LikingsHelper
  def render_like_link(likable)
    present likable do |likable_presenter|
      return likable_presenter.like_link
    end
  end

  def render_likes(likable)
    if likable.is_a?(Comment)
      return render_num_likings(likable)
    else
      return render_first_and_other_likers(likable)
    end
  end
  
  private

  def render_first_and_other_likers(likable)
    present likable do |likable_presenter|
      return likable_presenter.first_and_other_likers
    end
  end

  def render_num_likings(likable)
    present likable do |likable_presenter|
      return likable_presenter.num_likings
    end
  end
end
