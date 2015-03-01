# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged?

  protected

	def authorize
		unless logged?
			redirect_to login_url, notice: "Proszę się zalogować"
		end
	end

	def logged?
		User.find_by(id: session[:user_id])
	end

end
