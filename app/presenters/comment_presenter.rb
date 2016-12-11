class CommentPresenter < BasePresenter
  include LikablePresenter
  include CommentablePresenter

  def delete_link
    if current_user == @object.author
      link_to 'Delete', comment_path(@object), method: :delete, 
                                               class: 'delete-comment'
    end
  end
end