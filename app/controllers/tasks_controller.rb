class TasksController < ApplicationController
  include EventScoped
  before_action :authenticate_user!
  before_action :load_event
  before_action :owns_event
  def create
    @task = Task.new(params[:task].permit(:name).merge(:event => @event, :owner => nil))
    unless @task.save
      flash[:error] = "Unable to save task"  
    end
    redirect_to @event
  end
end
