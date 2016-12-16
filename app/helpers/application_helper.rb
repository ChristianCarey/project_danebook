module ApplicationHelper
  
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def post_or_photo_form(photo)
    if photo == "true"
      render 'photos/form' 
    else
      render 'posts/form' 
    end
  end
end
