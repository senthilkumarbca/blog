 class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
   skip_before_action :verify_authenticity_token, if: :json_request?

   def json_request?
     request.format.json?
   end
   protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
     devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
   end

   def after_sign_out_path_for(resource)
     posts_path
   end


end
