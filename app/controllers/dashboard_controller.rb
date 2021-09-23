class DashboardController < ApplicationController
  def index
    @workflows = Workflow.all
  end
end
