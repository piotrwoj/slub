# -*- encoding : utf-8 -*-

class MainController < ApplicationController

	skip_before_filter :authorize
	
  def index
  end

  def ceremony
  end
end
