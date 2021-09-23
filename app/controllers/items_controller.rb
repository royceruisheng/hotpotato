class ItemsController < ApplicationController
  def index
    @items = Item.all
    #change it to include task_id when task is connected

    respond_to do |format|
      format.html
      format.text { render partial: @items, formats: [:html] }
    end
  end

  def new
    @item = Item.new
    respond_to do |format|
      format.html
      format.text { render partial: 'items/itemform',locals: { item: @item }, formats: [:html] }
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :task_id)
  end
end