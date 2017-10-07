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
    if @task.name.blank?
      flash[:alert] = "Task must have a name"
    else
      unless @task.save
        flash[:alert] = "Unable to save task"  
      end
    end
    redirect_to @event
  end

  # Deletes a task from the database
  # PRE: The task is loaded
  # POST: Either the task is deleted if it existed, or an error is returned to the user
  def destroy
    unless @task.destroy
      flash[:alert] = "Unable to destroy task"
    end
    redirect_back fallback_location: @event
  end

  # Updates a task in the database (used for both task assignment and name change)
  # PRE: The task is loaded and the form input is sane
  # POST: The task is updated
  def update
    permitted_params = params[:task].permit(:name, :user)
    if permitted_params.key?("name")
      if owns_event
        name = permitted_params[:name]
        if name.blank?
          flash[:alert] = "Task name must not be empty"
        else
          @task.name = name
        end
      end
    elsif permitted_params.key?("user")
      proposed_user_id = permitted_params[:user]
      proposed_user = nil
      unless proposed_user_id.blank?
        proposed_user = User.find(proposed_user_id)
      end
      if @task.user == nil || current_user == @task.user
        @task.user = proposed_user
      end
    end
    unless @task.save
      flash[:alert] = "Unable to save task"
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
      flash[:alert] = "Unable to load task"
      redirect_to @event
    end
  end
end
