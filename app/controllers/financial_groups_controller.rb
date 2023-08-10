class FinancialGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @currentuser = current_user.name
    @allgroups = current_user.financial_groups
    @total_amounts = {}

    @allgroups.each do |group|
      @total_amounts[group] = group.financial_entities.sum(:amount)
    end
  end

  def new
    @new_financial_group = FinancialGroup.new
  end

  def create
    @new_financial_group = FinancialGroup.new(financial_group_params)
    @new_financial_group.user = current_user

    if @new_financial_group.save
      redirect_to financial_groups_path, notice: 'Financial Group created succesfully.'
    else
      render :new
    end
  end

  private

  def financial_group_params
    params.require(:financial_group).permit(:name, :icon)
  end
end
