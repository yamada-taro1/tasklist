class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy, :show, :edit, :update]

    def index
        @tasks = current_user.tasks.order(id: :desc).page(params[:page]) 
    end

    def show
    end

    def new
        @task = Task.new(content:'')
    end

    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = 'タスクの作成が完了しました'
            redirect_to @task
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
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
            flash.now[:danger] = 'タスクの変更に失敗しました'
            render :edit
        end
    end

    def destroy
        @task.destroy
        flash[:success] = 'タスクの削除に成功しました'
        redirect_to tasks_url
    end
    
    private
    
    def task_params
        params.require(:task).permit(:content, :status)
    end

    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end
