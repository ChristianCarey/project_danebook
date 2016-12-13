require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  let(:comment) { build(:comment) }

  it "is valid with default values" do 
    expect(comment).to be_valid
  end

  context "belongs to" do 

    specify "author" do 
      expect(comment).to respond_to(:author)
    end

    specify "commentable" do
      expect(comment).to respond_to(:commentable)
    end
  end

  describe "default scope" do 

    let(:second_comment) { build(:comment) }

    it "orders by newest first" do 
      comment.save
      second_comment.save
      expect(Comment.all).to eq([second_comment, comment])
    end
  end
end
