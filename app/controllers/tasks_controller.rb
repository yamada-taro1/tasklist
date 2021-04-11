class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
        @tasks = Task.all
    end

    def show
    end

    def new
        @task = Task.new(content:'')
    end

    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = 'タスクの作成が完了しました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクの作成に失敗しました'
            render :new
        end
    end

    def edit
    end

    def update

        if @task.update(task_params)
            flash[:success] = 'タスクの変更が完了しました'
            redirect_to @task
        else
            flash.now[danger] = 'タスクの変更に失敗しました'
            render :edit
        end
    end

    def destroy
        @task.destroy
        
        flash[:success] = 'タスクの削除に変更しました'
        redirect_to tasks_url
    end
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    def task_params
        params.require(:task).permit(:content, :status)
    end

end
