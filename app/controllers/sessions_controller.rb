# -*- encoding : utf-8 -*-

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(login: params[:login])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to books_url, notice: "Zalogowano"
    else
      redirect_to login_url, alert: "Nieprawidłowy login i/lub hasło"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to books_url, notice: "Wylogowano"
  end
end
