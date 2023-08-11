class FinancialEntitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @financial_group = FinancialGroup.includes(:financial_entities).find(params[:financial_group_id])
    @all_entities = @financial_group.financial_entities.where(author: current_user).order(created_at: :desc)
    @total_amount_for_category = @all_entities.sum(:amount)
  end

  def new
    @financial_group = FinancialGroup.find(params[:financial_group_id])
    @new_financial_entity = FinancialEntity.new
  end

  def create
    @financial_group = FinancialGroup.find(params[:financial_group_id])
    @new_financial_entity = @financial_group.financial_entities.build(financial_entity_params)
    @new_financial_entity.author = current_user

    if @new_financial_entity.save
      Categorisation.create(financial_group: @financial_group, financial_entity: @new_financial_entity)
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
