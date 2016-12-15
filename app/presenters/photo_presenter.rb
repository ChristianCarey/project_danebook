class PhotoPresenter < BasePresenter
  include LikablePresenter
  include CommentablePresenter
  include DeletablePresenter
end
