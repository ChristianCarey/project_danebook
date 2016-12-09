class BasePresenter
  
  def initialize(post, template)
    @post     = post
    @template = template
  end

  private

  def method_missing(*args, &block)
    @template.send(*args, &block)
  end
end