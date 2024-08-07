class Users::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?

      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        render json: { success: true, message: 'Signed up successfully.' }
      else
        expire_data_after_sign_in!
        render json: { success: true, message: 'Registration completed. Please check your email for confirmation instructions.' }
      end
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
