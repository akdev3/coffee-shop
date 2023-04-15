class Api::V1::GroupItemsController < Api::V1::ApplicationController
  before_action :set_items, only: [:create, :update]
  before_action :set_group_item, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @group_items = GroupItem.all
    respond_to do |format|
      format.html
      format.json { render json: @group_items }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @group_item }
    end
  end

  def create
    @group_item = GroupItem.new(group_item_params.except(:items))

    if @group_item.save
      @items.each do |item|
        @group_item.items << item
      end
      render json: @group_item, status: :created
    else
      render json: @group_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @group_item.update(group_item_params)
      render json: @group_item
    else
      render json: @group_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @group_item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Group item was successfully destroyed." }
      format.json { render json: @group_item }
    end
  end

  private

  def set_items
    @items = Item.where(id: group_item_params[:items].pluck(:id))
  end

  def set_group_item
    @group_item = GroupItem.find(params[:id])
  end

  def group_item_params
    params.permit(:name, :disc_amount, items: [:id])
  end
end
