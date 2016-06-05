class HomeController < ApplicationController

  def index
    if authenticated?
      redirect_to sales_url
    end
  end

end
