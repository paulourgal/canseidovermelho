class PlatformController < ApplicationController
  before_filter :check_authentication

  private

  def check_authentication
    unless authenticated?
      redirect_to root_url
    end
  end

end
