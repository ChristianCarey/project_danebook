require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let(:post) { build(:post) }
  
  it "is valid with default values" do 
    expect(post).to be_valid
  end

  context "belongs_to" do 
    specify "author" do 
      expect(post).to respond_to(:author)
    end
  end

  describe "content" do

    it "must be present" do 
      expect(build(:post, content: "")).to_not be_valid
    end
  end

  describe "#timeline" do 
    
    let(:second_post) { build(:post) }
    let(:third_post)  { build(:post) }
    
    before do 
      post.save
      second_post.save
      third_post.save
    end

    it "orders by newest first" do 
      expect(Post.timeline).to eq([third_post, second_post, post])
    end

    # TODO find out how to test "includes"?
  end
end
