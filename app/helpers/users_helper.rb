module UsersHelper
  def profile_photo(user, size = :large, css_class = "")
    if user.profile_photo
      image_tag user.profile_photo.image.url(size), class: css_class
    else
      image_tag 'http://hope4merton.com/wp-content/uploads/2015/12/profile-placeholder.gif', class: css_class
    end
  end
end
