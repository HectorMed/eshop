Rails.application.routes.draw do


  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: { new: '/'}
    resources :sessions, only: [:new, :create, :destroy], path: 'login', path_names: { new: '/' }
  end
  
  resources :favorites, only: [:index, :create, :destroy], param: :product_id

  resources :users, only: :show, path: '/user', param: :username
  resources :categories, except: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  #Metodos DELETE para eliminar registros
  # delete '/products/:id', to: 'products#destroy'

  #Metodos Patch, sirve para actualizar datos ya existentes
  # patch '/products/:id', to: 'products#update'

  #Metodos Post
  # post '/products', to: 'products#create'

  #Metodos Get
  # get '/products/new', to: 'products#new', as: :new_product #El metodo new despliega el formulario para agregar nuevos productos a la DataBase
  # get '/products', to: 'products#index' #El metodo index sirve para mostrar un conjunto de elementos
  # get '/products/:id', to: 'products#show', as: :product #El metodo SHOW sirve para mostrar un SOLO producto
  # get '/products/:id/edit', to: 'products#edit', as: :edit_product

  #Esta linea de codigo hace todo lo de arriba jaja
  resources :products, path: '/'
  #El path hace que todo lo que este en PRODUCTS resida en esa direccion, si escribimos por ejemplo /Pokémon, al ir a esa direccion
  #se nos mostrarán los productos y el listado

end
