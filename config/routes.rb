Expat::Engine.routes.draw do
  root 'locales#index'

  resources :locales, only: [] do
    resources :translations, id: /[^\/]+/
  end
end
