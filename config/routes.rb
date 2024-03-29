
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  require "sidekiq/cron/web"

  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }
  use_doorkeeper

  mount MailPreview => "mail_view" if Rails.env.development?

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  authenticate :user, ->(u) { u.director? } do
    mount Sidekiq::Web => "/sidekiq"
    mount Blazer::Engine, at: "blazer"
  end

  # devise doesnt parse GET /user
  resource :user, only: :show, constraints: ->(req) { req.format == :json }

  resource :questionnaires, path: "apply" do
    get :schools, on: :collection
  end

  resource :rsvp do
    get :accept, on: :collection
    get :deny, on: :collection
  end

  resource :bus_list do
    patch :boarded_bus, on: :collection
  end

  resource :events, only: :show, constraints: ->(req) { req.format == :json }

  namespace :manage do
    authenticate :user, ->(u) { u.director? } do
      root to: "dashboard#index"
    end
    authenticate :user, ->(u) { u.organizer? } do
      root to: "dashboard#index", as: :organizer_root
    end
    authenticate :user, ->(u) { u.volunteer? } do
      root to: "checkins#index", as: :volunteer_root
    end
    resources :dashboard do
      get :map_data, on: :collection
      get :todays_activity_data, on: :collection
      get :todays_stats_data, on: :collection
      get :checkin_activity_data, on: :collection
      get :confirmation_activity_data, on: :collection
      get :application_activity_data, on: :collection
      get :schools_confirmed_data, on: :collection
      get :user_distribution_data, on: :collection
      get :application_distribution_data, on: :collection
      get :schools_confirmed_data, on: :collection
      get :schools_applied_data, on: :collection
    end
    resources :questionnaires do
      patch :check_in, on: :member
      patch :update_acc_status, on: :member
      patch :bulk_apply, on: :collection
    end
    resources :checkins do
      post :datatable, on: :collection
    end
    resources :events do
    end
    resources :messages do
      get :preview, on: :member
      get :live_preview, on: :collection
      patch :deliver, on: :member
      patch :duplicate, on: :member
      # Message template
      get :template, on: :collection
      get :template_preview, on: :collection
      patch :template_update, on: :collection
      post :template_replace_with_default, on: :collection
    end
    resources :bus_lists do
      post :toggle_bus_captain, on: :member
      patch :send_update_email, on: :member
    end
    resources :schools do
      post :datatable, on: :collection
      get :merge, on: :member
      patch :perform_merge, on: :member
    end
    resources :stats do
      post :checked_in_datatable, on: :collection
    end
    resources :users do
      patch :reset_password, on: :member
    end
    resources :agreements
    resources :configs do
      patch :update_only_css_variables, on: :member
      get :enter_theming_editor, on: :collection
      get :exit_theming_editor, on: :collection
    end
    resources :trackable_events
    resources :trackable_tags
    resources :data_exports
  end
end
