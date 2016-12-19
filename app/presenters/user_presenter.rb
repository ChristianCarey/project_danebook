class UserPresenter < BasePresenter
  include FriendablePresenter

  private

  def user
    @object
  end
end