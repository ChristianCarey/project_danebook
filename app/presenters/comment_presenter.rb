class CommentPresenter < BasePresenter
  include LikablePresenter
  include CommentablePresenter
  include DeletablePresenter
end