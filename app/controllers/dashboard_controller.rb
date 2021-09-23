class DashboardController < ApplicationController
  def index
    @workflows = Workflow.limit(20)
    @workflow = false
  end
end
