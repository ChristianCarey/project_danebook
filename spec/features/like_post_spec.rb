require 'rails_helper'

feature "user likes post" do 

  let(:user){ create(:user) }
  let(:post){ build(:post) } 

  before do
    log_in(user)
    create_post(user, post)
  end

  context "when liking" do 

    before do 
      click_link 'Like'
    end

    scenario "link text changes to unlike" do 
      expect(find_link('Unlike')).to be_present
    end

    scenario "post is added to user's liked posts" do 
      expect(user.liked_posts.size).to eq(1)
    end
  end

  context "when unliking" do 

    before do 
      click_link "Like"
      click_link "Unlike"
    end

    scenario "link text changes to like" do 
      expect(find_link('Like')).to be_present
    end

    scenario "post is removed from user's liked posts" do 
      expect(user.liked_posts.size).to eq(0)
    end
  end

end