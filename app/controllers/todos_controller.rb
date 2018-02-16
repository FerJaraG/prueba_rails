class TodosController < ApplicationController

	def index
		@todos = Todo.all
	end

	def new
		@todo = Todo.new
	end

	def create
		todo = Todo.new(todo_params)
		todo[:completed] = false
		if todo.save
			redirect_to todo, notice: 'Se creo tarea con exito'
		else
			redirect_to todos_new_path, notice: 'No se pudo crear tarea :('
		end
	end

	def show
		@todo = Todo.find(params[:id])
	end

	def edit
		@todo = Todo.find(params[:id])
	end

	def update
		@todo = Todo.find(params[:id])
		if @todo.update(todo_params)
			redirect_to @todo, notice: 'La tarea se ha actualizado con exito'
		else
			redirect_to edit_path(@todo.id), notice: 'No se ha podido actualizar la tarea'
		end
	end

	def destroy
		@todo = Todo.find(params[:id])
		@todo.destroy
		redirect_to @todo, notice: 'El registro se ha eliminado con exito'
	end

	def complete
		@todo = Todo.find(params[:id])
		@todo[:completed] = true
		@todo.save
		redirect_to @todo, notice: 'La tarea se ha completado con exito'
	end

	def list
		@todos = Todo.all
	end


	private

	def todo_params
		params.require(:todo).permit(:description,:completed)
	end

end
