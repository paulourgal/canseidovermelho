class IncomingsController < ApplicationController

  def index
    if authenticated?
      @incomings = Incoming.by_user(current_user)
      render :index
    else
      redirect_to log_in_path
    end
  end

end
