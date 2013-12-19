Limspec::Application.routes.draw do

  resources :responses


  resources :organizations


  resources :user_questions

  unless ENV['DEPLOYING']
    use_doorkeeper
  end


  post "administration/send_announce", :as => "system_announcement"

  post "administration/contact", :as => "contact"

  match "administer", :to => "administration#display"

  match "contact_us", :to => "administration#contact_us"

  match 'vendorRequest/createPublicRequirementDoc', to: 'vendor_requests#produceRFP'

  match 'vendorRequest/createPrivateRequirementDoc', to: 'vendor_requests#produceUserRFP'

  match '/auth/:provider/callback', to: 'sessions#create'

  match "/auth/failure", to: "sessions#failure"

  match "/logout", to: "sessions#destroy", :as => "logout"

  match '/requirements/getXML', to: 'requirements#download_xml'

  match '/requirements/delimitedExport', to: 'requirements#getDelFile'

  get "/requirements/change_industry_setting"

  get "/requirements/change_selected_setting"

  get "/questions/change_industry_setting"

  get "/questions/change_selected_setting"

  match '/questions/getXML', to: 'questions#download_xml'

  match '/questions/delimitedExport', to: 'questions#getDelFile'

  get "/sessions/new", as:'login'

  get "/sessions/create"

  get "/sessions/destroy"

  get "/sessions/failure"

  get "/authentications/index"

  get "/authentications/destroy"

  get "/authentications/create"

  get "/app_settings/show", as: :app_settings

  get "/app_settings/edit", as: :edit_app_setting

  resources :app_settings, :only => :update

  resources :identities

  namespace :api  do
       namespace :v1 do
          resources :users, only: [:index, :create], defaults: {format: :json}
       end

    end

  resources :users

  resources :roles

  resources :industries

  resources :categories

  resources :password_resets

  get "/requirements/review", as: :review_requirements

  resources :requirements do
    collection do
      put 'change_selected_requirements', :as => :change_selected
    end
  end

  get "/questions/review", as: :review_questions

  resources :questions do
    collection do
     put 'change_selected_questions', :as => :change_selected
    end
  end

  match '/user_requirements/getXML', to: 'user_requirements#download_xml'
  match "user_requirements/revert/:id", to: "user_requirements#revert", as: :revert_user_requirement

  resources :user_requirements do
       collection { post :updateSort}
  end

  match '/user_questions/getXML', to: 'user_questions#download_xml'
  match "user_questions/revert/:id", to: "user_questions#revert", as: :revert_user_question

    resources :user_questions do
         collection { post :updateSort}
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: "requirements#index"


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
