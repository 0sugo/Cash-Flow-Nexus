class FinancialEntitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @financial_group = FinancialGroup.find(params[:financial_group_id])
    @allEntities = @financial_group.financial_entities.where(author: current_user).order(created_at: :desc)
    @totalAmountForCategory = @allEntities.sum(:amount)
  end

  def new
    @financial_group = FinancialGroup.find(params[:financial_group_id])
    @newFinancialEntity = FinancialEntity.new
  end

  def create
    @financial_group = FinancialGroup.find(params[:financial_group_id])
    @newFinancialEntity = @financial_group.financial_entities.build(financial_entity_params)
    @newFinancialEntity.author = current_user

    if @newFinancialEntity.save
      Categorisation.create(financial_group: @financial_group, financial_entity: @newFinancialEntity)
      redirect_to financial_group_financial_entities_path(@financial_group), notice: 'Transaction added successfully.'
    else
      render :new
    end
  end


  private
  def financial_entity_params
    params.require(:financial_entity).permit(:name, :amount)
  end
end


