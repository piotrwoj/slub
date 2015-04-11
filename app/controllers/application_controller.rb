# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  helper_method :admin?

  protected

	def authorize
		unless admin?
			redirect_to login_url, notice: "Proszę się zalogować"
		end
	end

	def admin?
		session[:user_id] and User.find_by(id: session[:user_id])
	end

end
