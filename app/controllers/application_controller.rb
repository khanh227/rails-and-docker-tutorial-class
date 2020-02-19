class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied, with: :render_403

  private
  def render_403
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end
end
