class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = User.find_by(email: params[:user][:email])

    if resource && resource.valid_password?(params[:user][:password])
      sign_in(resource_name, resource)
      session[:user_id] = resource.id
      session_id = SecureRandom.uuid
      render json: { success: true, message: 'Logged in successfully.', session_id: session_id, resource: resource }
    elsif !resource
      render json: { success: false, message: 'Please enter a valid email address' }, status: :not_found
    elsif !resource.valid_password?(params[:user][:password])
      render json: { success: false, message: 'Invalid password. Please enter a valid password' }, status: :unauthorized
    else
      render json: { success: false }, status: :unauthorized
    end
  end
end
