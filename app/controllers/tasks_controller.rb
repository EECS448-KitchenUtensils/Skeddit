class TasksController < ApplicationController
  include EventScoped
  before_action :authenticate_user!
  before_action :load_event
  before_action :load_task, :only => [:update, :destroy]
  before_action :owns_event, :only => [:create, :destroy]

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
  # PRE: The task is loaded
  # POST: Either the task is deleted if it existed, or an error is returned to the user
  def destroy
    unless @task.destroy
      flash[:error] = "Unable to destroy task"
    end
    redirect_to @event
  end

  # Updates a task in the database
  # PRE: The task is loaded and the form input is sane
  # POST: The task is updated
  def update
    proposed_name = params[:task].permit(:name)[:name]
    @task.name = proposed_name if !proposed_name.blank? else @task.name
    unless @task.save
      flash[:error] = "Unable to save task"
    end
    redirect_to @event
  end

  private

  # Loads the task model in
  # PRE: None
  # POST: Task is loaded or user gets an error
  def load_task
    task_id = params[:id]
    @task = @event.tasks.where(id: task_id).first
    unless @task
      flash[:error] = "Unable to load task"
      redirect_to @event
    end
  end
end
