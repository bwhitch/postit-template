class SessionsController < ApplicationController
	def new

	end

	def create

		user = User.find_by(username: params[:username])

		if user && user.authenticate(params[:password])
			session[:id] = user.id
			flash[:notice] = "Welcome"
			redirect_to root_path

		else
			flash[:error] = "There's something wrong with your username or password"
			redirect_to login_path
		end
	end

	def destroy
		session[:id] = nil
		flash[:notice] = "Logged out"
		redirect_to root_path
	end

end