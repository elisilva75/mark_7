
require 'httparty'

class TasksService
  include HTTParty

  def login(email, password)
    result = HTTParty.post(
      'http://mark7.herokuapp.com/api/login',
      body: { email: email, password: password }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    result.parsed_response['data']
  end

  def new_task(email, password)
    @token = login(email, password)
    request = {
      title: 'Tarefa para Testes',
      dueDate: '2018/01/01',
      tags: %w[
        tag1 tag2 tag3
      ],
      done: false
    }

    HTTParty.post(
      'https://mark7.herokuapp.com/api/tasks',
      body: request.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'X-User-Id' => @token['userId'],
        'X-Auth-Token' => @token['authToken']
      }
    )
  end

  def delete_all(email, password)
    @token = login(email, password)

    result = HTTParty.delete(
      'https://mark7.herokuapp.com/api/tasks',
      headers: {
        'Content-Type' => 'application/json',
        'X-User-Id' => @token['userId'],
        'X-Auth-Token' => @token['authToken']
      }
    )
  end
end
