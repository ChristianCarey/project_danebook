class PostPresenter < BasePresenter

  def delete_link
    if current_user == @post.author
      link_to 'Delete', user_post_path(@post.author, @post), method: :delete, 
                                                             class: 'delete-post'
    end
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
