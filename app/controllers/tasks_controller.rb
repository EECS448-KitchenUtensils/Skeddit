class TasksController < ApplicationController
  include EventScoped
  before_action :authenticate_user!
  before_action :load_event
  before_action :owns_event
  skip_before_action :owns_event, only: [:index, :show]
  def new
    @task = Task.new
  end
  def index
    @tasks = Task.all
  end
end
