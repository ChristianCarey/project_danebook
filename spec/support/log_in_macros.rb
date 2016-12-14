module LogInMacros

  def log_in(user)
    visit login_path
    within "form#nav-login-form" do 
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "Sign In"
    end
  end
end