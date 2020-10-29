describe 'Cadastrar' do 
    def login(field_email, field_password)
        @body = {
            session: {
                email: field_email,
                password: field_password
            }
        }.to_json

        @login = Login.post('/sessions', body: @body)
    end

    context 'tarefas' do 
        before { login('a@teste.com.br', '123456') }

        it 'com sucesso' do
            @header = {
                'Content-Type': 'application/json',
                Accept: 'application/vnd.tasksmanager.v2',
                Authorization: @login.parsed_response['data']['attributes']['auth-token']
            }

            @body = {
                task: {
                    title: 'Tarefa Criada',
                    description: 'Descrição da tarefa criada com sucesso api teste.',
                    deadline: '2020-10-29 10:11:00',
                    done: true
                }
            }.to_json

            @tarefas = Cadastrar.post('/tasks', body: @body, headers: @header)
            puts @tarefas
            expect(@tarefas.parsed_response['data']['attributes']['title']).to eq 'Tarefa Criada'
        end        
    end
end