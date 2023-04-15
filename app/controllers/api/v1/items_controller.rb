class Api::V1::ItemsController < Api::V1::ApplicationController
  before_action :set_item, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    @items = Item.all
    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @item }
    end
  end

  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render json: @item, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render json: @item, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { render json: @item }
    end
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :price)
    end
end
