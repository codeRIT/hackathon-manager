# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  require "sidekiq/web"
  require "sidekiq/cron/web"

  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }
  use_doorkeeper

  mount MailPreview => "mail_view" if Rails.env.development?

  devise_scope :user do
    authenticated do
      root to: "questionnaires#show"
    end

    unauthenticated do
      root to: "devise/sessions#new"
    end
  end

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount Blazer::Engine, at: "blazer"
  end

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

  namespace :manage do
    root to: "dashboard#index"
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
      post :datatable, on: :collection
      patch :check_in, on: :member
      patch :convert_to_admin, on: :member
      patch :update_acc_status, on: :member
      patch :bulk_apply, on: :collection
      get :message_events, on: :member
    end
    resources :extra_questions do

    end
    resources :checkins do
      post :datatable, on: :collection
    end
    resources :users do
      post :user_datatable, on: :collection
      post :admin_datatable, on: :collection
      patch :reset_password, on: :member
    end
    resources :messages do
      get :preview, on: :member
      get :live_preview, on: :collection
      post :datatable, on: :collection
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
      post :dietary_special_needs, on: :collection
      post :sponsor_info, on: :collection
      post :alt_travel, on: :collection
      post :mlh_info_applied, on: :collection
      post :mlh_info_checked_in, on: :collection
    end
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
