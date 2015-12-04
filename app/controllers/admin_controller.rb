class AdminController < ApplicationController
	before_filter :authenticate_user!
	def list
		if current_user.admin?
			@list = User.all
		else
			 redirect_to(root_path, :notice => 'No tiene autorización para realizar esta acción.')
		end


	end

	def edit
		if current_user.admin?
			@resource = User.find_by_id(params[:id])
		else
			 redirect_to(root_path, :notice => 'No tiene autorización para realizar esta acción.')
		end
	end

	def new
		
	end

	def delete_user
		if current_user.admin?

			@user = User.find_by_id(params[:destroy_id])

			@user.destroy
		    respond_to do |format|
		      flash[:notice] = 'Usuario eliminado con éxito.'
		      format.html { redirect_to users_list_path }
		      format.json { head :no_content }
		    end
		else
			 redirect_to(root_path, :notice => 'No tiene autorización para realizar esta acción.')
		end
	end

	def create_user
		if current_user.admin?
		    @user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password], :role => 'client')

		    respond_to do |format|
				if @user.save
				  format.html { redirect_to new_user_path, notice: 'Usuario creado con éxito.' }
				else
				  flash[:notice] = 'Error al crear usuario, por favor intentelo nuevamente.'
				  format.html { render action: 'new'}
				  format.json { render json: @user.errors, status: :unprocessable_entity }
				end
			end
		else
		    redirect_to(root_path, :notice => 'No tiene autorización para realizar esta acción.')
		end
	end

end
