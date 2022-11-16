class SessionsController < ApplicationController

  def create
  end

  def destroy
    loggout
    redirect_to users_url
  end


end
