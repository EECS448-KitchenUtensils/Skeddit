class TasksController < ApplicationController
  include EventScoped
  before_action :authenticate_user!
  before_action :load_event
  before_action :owns_event
  
  # Creates a new task in the database
  # PRE: None
  # POST: Either a task is created in the database, or an error is returned to the user
  def create
    @task = Task.new(params[:task].permit(:name).merge(:event => @event))
    unless @task.save
      flash[:error] = "Unable to save task"  
    end
    redirect_to @event
  end

  # Deletes a task from the database
  # PRE: The given task must exist
  # POST: Either the task is deleted if it existed, or an error is returned to the user
  def destroy
    task_id = params[:id]
    @task = @event.tasks.where(id: task_id).first
    unless @task.destroy
      flash[:error] = "Unable to destroy task"
    end
    redirect_to @event
  end
end
