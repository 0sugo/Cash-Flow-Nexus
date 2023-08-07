class FinancialGroupsController < ApplicationController
  before_action :authenticate_user!,except: %i[index show]

  def index
    @currentUser = if user_signed_in?
      current_user.name
    else
        'Guest'
      end
  end

end
