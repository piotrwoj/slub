# -*- encoding : utf-8 -*-

class MainController < ApplicationController

	skip_before_filter :authorize, only: [:index, :directions]
	
  def index
  end

  def directions
  end

  def disable_reservations
  	Settings.reservations = 'off'
  	redirect_to users_path, notice: 'Zablokowano możliwość rezerwacji książek'
  end

  def enable_reservations
  	Settings.reservations = 'on'
  	redirect_to users_path, notice: 'Włączono możliwość rezerwacji książek'
  end
end
