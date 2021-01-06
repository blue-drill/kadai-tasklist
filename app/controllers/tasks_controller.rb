class TasksController < ApplicationController
  before_action :set_correct_user_task, only:[:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクを登録しました'
      redirect_to @task
    else
      flash[:danger] = 'タスクを登録できませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクを変更しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクを変更できませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクを削除しました'
    redirect_to tasks_url
  end
  
  private
  
  def set_correct_user_task
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
