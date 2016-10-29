class TasksController < ApplicationController

	before_action :find_project
	before_action :find_task, except: [:create]
	
	def create
		@task = @project.tasks.build(task_params)

		if @task.save
			redirect_to @project
		else
			render 'new'
		end
	end

	def destroy
		
		if @task.destroy
			flash[:notice] = "Your task have been deleted !"
		else
			fllash[:error] = "Task haven't been deleted !"
		end

		redirect_to @project
	end

	def complete
		@task.update_attribute(:completed_at, Time.now)
		redirect_to @project, notice: "Your task have been completed"
	end

	private

	def find_project
		@project =Project.find(params[:project_id])
	end

	def find_task
		@task = @project.tasks.find(params[:id])
	end

	def task_params
		params.require(:task).permit(:content)
	end
end
