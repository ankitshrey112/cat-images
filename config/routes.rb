Rails.application.routes.draw do
  devise_for :users
  root 'cat_images#health'

  post 'cat_images/create', to: 'cat_images#create_cat_image'

  post 'cat_images/update', to: 'cat_images#update_cat_image'

  post 'cat_images/delete', to: 'cat_images#delete_cat_image'

  get 'cat_images/list', to: 'cat_images#list_cat_images'

  get 'cat_images/get', to: 'cat_images#get_cat_image'
end
