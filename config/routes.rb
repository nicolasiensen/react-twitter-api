Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tweets#index"
  put 'tweets/:id/archive', to: 'tweets#archive'
  get 'request_token', to: 'oauth#request_token'
  get 'access_token', to: 'oauth#access_token'
end
