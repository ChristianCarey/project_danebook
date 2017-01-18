module ApplicationHelper
  
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def present_collection(collection, klass = nil)
    collection_name = collection.class.to_s.split('::')[0].pluralize
    klass ||= "#{collection_name}Presenter".constantize
    presenter = klass.new(collection, self)
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

  def render_activity(activity)
    type = activity.class.to_s
    locals = { activity: activity, presenter: "#{type}Presenter" }
    locals[type.downcase.underscore.to_sym] = activity
    render "activities/#{type.downcase.underscore}", locals
  end
end
