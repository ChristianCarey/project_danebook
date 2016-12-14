module SignUpMacros

  def sign_up(user)
    within "form#new_user" do 
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password_confirmation
      click_on "Sign Up"
    end
  end
end