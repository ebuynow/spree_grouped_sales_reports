Spree::Core::Engine.routes.draw do
  get 'admin/reports/grouped_sales', controller: 'admin/reports', action: 'grouped_sales', as: 'grouped_sales_admin_reports'
  post 'admin/reports/grouped_sales', controller: 'admin/reports', action: 'grouped_sales'

  namespace :admin do
    resources :sales_report_groups do
      resources :sales_report_group_variants, only: [:new, :create]
    end

    resources :sales_report_group_variants, only: [:destroy]
  end
end
