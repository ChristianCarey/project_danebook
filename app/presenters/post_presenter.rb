class PostPresenter < BasePresenter
  include LikablePresenter
  include CommentablePresenter
  include DeletablePresenter
end
