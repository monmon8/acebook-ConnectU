class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_action :require_login
  protect_from_forgery with: :exception

  # ActionCable.server.config.allowed_request_origins = ['http://ruby.app:3000']

  def index; end

  private

  def require_login
    # puts 'running require login method'
    if signed_out? && request.env['PATH_INFO'] != '/'
      flash[:error] = 'You must be logged in to access this section'
      redirect_to('/') # halts request cycle
    end
  end
end
