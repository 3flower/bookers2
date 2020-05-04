Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]

  resources :books do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
	end

  root 'homes#top'
  get "home/about" => "homes#about"

end

#POST	/books/:book_id/favorites(.:format)	favorites#create book_favorite_path
#	DELETE	/books/:book_id/favorites/:id(.:format)	favorites#destroy