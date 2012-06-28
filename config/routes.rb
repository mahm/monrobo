Monrobo::Application.routes.draw do
  root to: "generate#index"
  match "/display", to: "generate#display", via: :post
  match "/image/:param_id", to: "generate#image", via: :get
end
