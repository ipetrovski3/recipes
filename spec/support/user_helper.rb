module UserHelper
  def log_in(user)
    visit login_path

    within('form') do
      fill_in 'Email', with: user.mail
      fill_in 'Password', with: user.password

      click_on 'Sign In'
    end
  end

end
