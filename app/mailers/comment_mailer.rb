class CommentMailer < ApplicationMailer
  default from: "vikings@danebook.dk"

  def new_comment(args = {})
    @commenter = args.fetch(:commenter)
    @commented = args.fetch(:commented)
    @comment   = args.fetch(:comment)

    mail(to: @commented.email, subject: "#{@commenter.name} commented on your #{@comment.commentable.class.to_s.downcase}.")
  end
end
