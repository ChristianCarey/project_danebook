module PostMacros

  def create_post(user, post)
    visit user_activities(user)
    within "form#new_post" do 
      fill_in "post_content", with: post.content
      click_button "Post"
    end
  end
end
