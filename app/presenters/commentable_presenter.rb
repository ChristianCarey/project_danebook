module CommentablePresenter
  def comments
    if @object.comments.any?
      content_tag(:div, "<hr> #{ comments_list } #{ comment_form }".html_safe, class: 'post-comments-container')
    end
  end

  private

  def comment_form
    render 'comments/form', commentable: @object
  end

  def comments_list
    render @object.comments
  end
end