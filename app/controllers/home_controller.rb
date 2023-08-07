class HomeController < ApplicationController
  def index
    @currentUser = if user_signed_in?
                    current_user.name
                  else
                      'Guest'
                    end
  end
end
