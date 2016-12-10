class PostPresenter < BasePresenter
  include LikablePresenter

  def delete_link
    if current_user == @object.author
      link_to 'Delete', user_post_path(@object.author, @object), method: :delete, 
                                                             class: 'delete-post'
    end
  end
end
