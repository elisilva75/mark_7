require_relative 'pages/login_page'
require_relative 'pages/tasks_page'
require_relative 'api/tasks_service'

describe('Tasks') do

    before(:all) do
        @login = LoginPage.new
        @tasks = TasksPage.new
        @tasks_service = TasksService.new

        @login.load
    end

    describe('nova tarefa', :new_task) do

        before(:all) do
            @tasks_service.delete_all('fernando@qaninja.io', '123456')
            @tasks_service.new_task('fernando@qaninja.io', '123456')

            @login.faz_login('fernando@qaninja.io', '123456')
        end

        it('quando o usuário preenche o formulário') do
            nova_tarefa = {
                name: 'Planejar minha viagem para Amsterdam',
                due_date: '2018/01/05',
                tags: ['amsterdam', 'viagem', 'ferias']
            }
    
            @tasks.insert_button.click
            @tasks.form.save(nova_tarefa)
    
            expect(@tasks.toast.message.text).to eql 'The task has been added.'

            @tasks.search(nova_tarefa[:name])
            expect(@tasks.trs.size).to eql 1

            result = @tasks.trs.first
            expect(result.text).to include nova_tarefa[:name]
            expect(result.text).to include nova_tarefa[:due_date]

            nova_tarefa[:tags].each { |t| expect(result.text).to include t }
        end

    end



end




# Cadastro de endereço de entrega

# Dado que estou na página de Cadastro
# E preencho o campo rua com "Av Paulista"
# E preencho o campo numero com "1000"
# E preencho o campo Bairro com "Cerqueira cezar"
# E preencho o campo Cidade com "São Paulo"
# E preencho o campo CEP com "0000-000"
# Quando clico em Cadastrar
# Então o endereço é cadastrado com sucesso

# Teste tradicional escrito em Gherkin


# BDT

# Testing Driven Development


# BDD

# Behavior  Driven Development
# Devenvolvimento Guiado por Comportamento

# BDD => Artefado que será usado para Desenvolver algo?????

# Testes => BDD só pra testar????? então não é BDD> BDT