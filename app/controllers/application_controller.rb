class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[fname lname subdomain time_zone])
  end

  def after_sign_out_path_for(resource)
    if resource.to_s == 'user'
      root_url(subdomain: 'www')
    else
      super
    end
  end
end
