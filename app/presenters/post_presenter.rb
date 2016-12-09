class PostPresenter
  def initialize(post, template)
    @post     = post
    @template = template
  end

  def h
    @template
  end

  def delete_link
    '<li class="delete-post"><a href="#">Delete</a></li>'.html_safe if h.current_user == @post.author
  end

  def first_and_other_likers
    if @post.likers.any?
      first = @post.likers.first
      remainder = @post.likers.count - 1
      if remainder = 0
        "#{first.name} likes this"
      else
        "#{first.name} and #{pluralize(remainder, 'other person')} like this"
      end
    end
  end
end
