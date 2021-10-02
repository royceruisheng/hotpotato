class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy, :move, :move_repo, :expand, :update, :check]

  # def index
  #   @items = Item.all
  #   #change it to include task_id when task is connected

  #   respond_to do |format|
  #     format.html
  #     format.text { render partial: @items, formats: [:html] }
  #   end
  # end

  def new
    @item = Item.new
    @task = Task.find(params[:task_id])
    respond_to do |format|
      # format.html
      format.text { render partial: 'items/itemform', locals: { item: @item, task: @task }, formats: [:html] }
    end
  end

  def create
    item_params = JSON.parse(request.body.read)
    @item = Item.new
    @item.title = item_params['title']
    @item.task = Task.find(item_params['taskId'])
    @task = @item.task

    if @item.save
      respond_to do |format|
        format.text { render partial: 'items/item', locals: { item: @item, task: @task, workflow: @item.task.workflow }, formats: [:html] }
      end
    # else
    #   redirect_to dashboard_path
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end

  def expand
    respond_to do |format|
      format.text { render partial: 'items/item_expanded', locals: { item: @item }, formats: [:html] }
    end
  end

  def check
    if @item.checked == true
      @item.checked = false
    else
      @item.checked = true
    end
    @item.save

    respond_to do |format|
      format.html { head :ok }
    end
  end

  def move
    user_item = @item.user_items.find_by(user_id: current_user.id)
    @item.insert_at(params[:position].to_i)
    if @item.update(move_item_params)
      head :ok
    end
    if user_item
      @item.user_items.find_by(user_id: current_user.id).destroy
    end
  end

  def move_repo
    @item.task_id = nil
    if @item.save
      @item.insert_at(params[:position].to_i)
      head :ok if UserItem.create(user_id: current_user.id, item_id: params[:id])
    end
  end

  def update
    description_params = JSON.parse(request.body.read)
    if @item.update(description_params)
      respond_to do |format|
        format.text { render partial: 'items/item_expanded', locals: { item: @item }, formats: [:html]}
      end
    end
  end

  private

  # def item_params
  #   params.require(:item).permit(:title, :task_id)
  # end

  def move_item_params
    params.permit(:task_id, :position, :id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
