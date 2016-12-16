class ActivitiesPresenter < CollectionPresenter

  def render_partials 
    result = ""
    activities.each do |activity|
      result += render(activity.trackable)
    end
    result.html_safe
  end

  private

  def activities
    @object
  end
end