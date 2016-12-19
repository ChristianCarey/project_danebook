class UsersPresenter < CollectionPresenter
  def users_found(query)
    if query.empty?
      content_tag :h3 do
        "All Users"
      end
    else
      content_tag :h3 do 
        "We found #{pluralize(users.size, "person")} with \"#{query}\" in their name."
      end
    end
  end

  private

  def users
    @object
  end

end