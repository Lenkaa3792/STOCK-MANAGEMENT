class Users::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    if resource.save
      sign_up(resource_name, resource)
        render json: { success: true, message: 'Signed up successfully.' }
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { success: false, message: resource.errors.full_messages.first }
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role)
  end
end
