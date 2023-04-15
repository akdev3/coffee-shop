class Api::V1::PromotionLineItemsController < Api::V1::ApplicationController
  before_action :set_promotion_line_item, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    @promotion_line_items = PromotionLineItem.all
    respond_to do |format|
      format.html
      format.json { render json: @promotion_line_items }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @promotion_line_item }
    end
  end

  def create
    @promotion_line_item = PromotionLineItem.new(promotion_item_params)

    respond_to do |format|
      if @promotion_line_item.save
        format.html { redirect_to item_url(@promotion_line_item), notice: "PromotionLineItem was successfully created." }
        format.json { render json: @promotion_line_item, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @promotion_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @promotion_line_item.update(promotion_item_params)
        format.html { redirect_to @promotion_line_item, notice: "PromotionLineItem was successfully updated." }
        format.json { render json: @promotion_line_item, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @promotion_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @promotion_line_item.destroy

    respond_to do |format|
      format.html { redirect_to promotion_line_items_url, notice: "PromotionLineItem was successfully destroyed." }
      format.json { render json: @promotion_line_item }
    end
  end

  private

    def set_promotion_line_item
      @promotion_line_item = PromotionLineItem.find(params[:id])
    end

    def promotion_item_params
      params.require(:promotion_line_item).permit(:source_item_id, :dest_item_id)
    end
end
