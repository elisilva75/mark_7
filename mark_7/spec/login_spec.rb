
require_relative 'pages/login_page'
require_relative 'pages/tasks_page'

describe('Login') do
  before do
    @login = LoginPage.new
    @tasks = TasksPage.new

    @login.load
  end
  describe('com sucesso') do
    it('quando o usuário é autenticado deve ver a lista de tarefas', :smoke) do
      @login.faz_login('fernando@papito.io', '123456')

      @tasks.wait_for_tasks_view
      expect(@tasks.page_title.text).to eql 'Tasks'
      expect(@tasks.top_menu.usermenu.text).to eql 'fernando@papito.io'
    end

    after do
      @tasks.top_menu.faz_logout
    end
  end

  describe('tentativa', :tentativa) do
    it('quando o usuário tenta acessar o sistema informando dados incorretos') do
      tentativas = [
        { email: 'fernando@papito.io', senha: 'abc123' },
        { email: 'padrekevedo@noekziste.org', senha: 'abc123' },
        { email: 'fernando&papito.io', senha: 'abc123' }
      ]

      resultado_obtido = []

      tentativas.each do |u|
        @login.faz_login(u[:email], u[:senha])
        @login.toast.wait_for_message
        resultado_obtido.push(output: @login.toast.message.text)
      end

      resultado_esperado = [
        { output: 'Incorrect password' },
        { output: 'User not found' },
        { output: 'Please enter your e-mail address.' }
      ]

      expect(resultado_obtido).to eql resultado_esperado
    end
  end
end
