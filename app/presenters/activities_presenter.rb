class ActivitiesPresenter < CollectionPresenter

  def render_partials 
    result = ""
    activities.each do |activity|
      result += render_partial(activity)
    end
    result.html_safe
  end

  def render_partial(activity)
    locals = { activity: activity, presenter: self }
    locals[activity.trackable_type.underscore.to_sym] = activity.trackable 
    render partial_path(activity), locals
  end

  private

  def partial_path(activity)
    "activities/#{activity.trackable_type.underscore}"
  end

  def activities
    @object
  end
end