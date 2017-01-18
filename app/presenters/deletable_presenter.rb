module DeletablePresenter
  def delete_link(css_class = "delete-post")
    if current_user == @object.author
      path = "#{@object.class.to_s.downcase}_path"
      link_to 'Delete', send(path, @object), method: :delete, remote: :true, class: css_class
    end
  end
end