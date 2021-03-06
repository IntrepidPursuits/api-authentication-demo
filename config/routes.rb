Rails.application.routes.draw do
  api_version(module: 'V1',
              header: {
                name: 'Accept',
                value: 'application/vnd.authentication-demo-app.com; version=1' },
              defaults: { format: :json }) do
    resources :users, only: :create
  end
end
