Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :rooms,     only: %i[index create show]
  resources :messages,  only: %i[create index]

  mount ActionCable.server => '/chat'
end
