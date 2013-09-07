class RegistrationController < Devise::RegistrationsController

	def create
	    @user = User.create!(:ip => request.remote_ip, :cookie => params["cookie"])
	    if @user.save
	    	render :json => @user.id
	    end
  	end

end
