module CommentablePresenter
  def comments
    content_tag(:div, "<hr> #{ comments_list } #{ comment_form }".html_safe, class: 'post-comments-container')
  end

  private

  def comment_form
    render 'comments/form', commentable: @object
  end

  def comments_list
    render @object.comments
  end
end