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
    @task = Task.find(params[:task_id])
    respond_to do |format|
      format.html
      format.text { render partial: 'items/itemform',locals: { item: @item, task: @task }, formats: [:html] }
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

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to dashboard_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :task_id)
  end
end
