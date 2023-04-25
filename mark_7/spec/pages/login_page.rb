
require_relative 'sections'

class LoginPage < SitePrism::Page
  set_url 'https://mark7.herokuapp.com'

  section :toast, Toast, '#toast-container'

  element :input_email, 'input[name=username]'
  element :input_password, 'input[name=password]'

  def faz_login(email, senha)
    input_email.set email
    input_password.set senha
    click_button 'Login'
  end
end


