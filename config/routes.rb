Rails.application.routes.draw do
  post '/hook_executions/:token' => 'hook_executions#create'
end
