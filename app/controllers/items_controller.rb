class ItemsController < ApplicationController

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
      redirect_to edit_user_registration_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :task_id)
  end
end
