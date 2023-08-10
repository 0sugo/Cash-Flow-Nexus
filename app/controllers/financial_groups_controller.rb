class FinancialGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @currentUser = current_user.name
    @allgroups = current_user.financial_groups
    @totalAmounts = {}

    @allgroups.each do |group|
      @totalAmounts[group] = group.financial_entities.sum(:amount)
    end
  end
  
  def new
    @newFinancialGroup = FinancialGroup.new
  end

  def create
    @newFinancialGroup = FinancialGroup.new(financial_group_params)
    @newFinancialGroup.user = current_user

    if @newFinancialGroup.save
      redirect_to financial_groups_path,notice: 'Financial Group created succesfully.'
    else
      render:new
    end
  end


  private

  def financial_group_params
    params.require(:financial_group).permit(:name, :icon)
  end
end
