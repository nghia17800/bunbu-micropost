class OmniauthCallbacksController < ApplicationController
  def facebook
    puts "OmniAuth callback hash: #{auth}"
    redirect_to root_path 
  end

  def auth
    request.env["omniauth.auth"]
  end
end
