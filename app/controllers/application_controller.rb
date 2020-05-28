class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[fname lname])
  end

  def after_sign_in_path_for(resource)
    super
    # root_url(subdomain: resource.website.subdomain)
  end
end
