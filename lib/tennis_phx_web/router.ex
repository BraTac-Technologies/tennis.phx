defmodule TennisPhxWeb.Router do
  use TennisPhxWeb, :router

  import TennisPhxWeb.AdminAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TennisPhxWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TennisPhxWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/ranking", PageController, :ranking
    resources "/tours", TourController, only: [:index]
    resources "/players", PlayerController, except: [:create, :edit, :show]
    resources "/tags", TagController, except: [:create, :edit, :index, :delete]

    live "/match/live_form", MatchLive
    live "/head2head", HeadtoHeadLive, :h2h
    live "/tour_live/:id", TourLive
    live "/players/:id", PlayerShowLive
  end

  scope "/", TennisPhxWeb do
    pipe_through [:browser, :require_authenticated_admin]

    resources "/matches", MatchController
    resources "/player_units", Player_unitController
    resources "/locations", LocationController
    resources "/phases", PhaseController
    resources "/statuses", StatusController
    resources "/tours", TourController, except: [:index]
    # resources "/players", PlayerController, except: [:index, :show]
    get "/players/new", PlayerController, :new
    post "/players", PlayerController, :create
    get "/players/:id/edit", PlayerController, :edit
    resources "/tags", TagController, except: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TennisPhxWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TennisPhxWeb.Telemetry

    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", TennisPhxWeb do
    pipe_through [:browser, :redirect_if_admin_is_authenticated]

    #get "/admins/register", AdminRegistrationController, :new
    #post "/admins/register", AdminRegistrationController, :create
    get "/admins/log_in", AdminSessionController, :new
    post "/admins/log_in", AdminSessionController, :create
    get "/admins/reset_password", AdminResetPasswordController, :new
    post "/admins/reset_password", AdminResetPasswordController, :create
    get "/admins/reset_password/:token", AdminResetPasswordController, :edit
    put "/admins/reset_password/:token", AdminResetPasswordController, :update
  end

  scope "/", TennisPhxWeb do
    pipe_through [:browser, :require_authenticated_admin]

    get "/admins/settings", AdminSettingsController, :edit
    put "/admins/settings", AdminSettingsController, :update
    get "/admins/settings/confirm_email/:token", AdminSettingsController, :confirm_email
    live "/admin/dashboard", DashboardLive, :index, as: :admin_dashboard
    live "/admin/tour_live/:id", AdminTourLive
  end

  scope "/", TennisPhxWeb do
    pipe_through [:browser]

    delete "/admins/log_out", AdminSessionController, :delete
    get "/admins/confirm", AdminConfirmationController, :new
    post "/admins/confirm", AdminConfirmationController, :create
    get "/admins/confirm/:token", AdminConfirmationController, :edit
    post "/admins/confirm/:token", AdminConfirmationController, :update
  end
end
