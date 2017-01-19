module ActivitiesHelper
  def render_activity(activity)
    type = activity.class.to_s
    locals = { activity: activity, presenter: "#{type}Presenter" }
    locals[type.downcase.underscore.to_sym] = activity
    render "activities/#{type.downcase.underscore}", locals
  end
end
