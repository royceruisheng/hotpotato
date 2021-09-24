class DashboardController < ApplicationController
  def index
    @workflows = Workflow.limit(20).reverse_order
    @workflow = false
  end
end
