# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    super do |resource|
      if request.subdomain == 'www'
        resource.subdomain = resource.get_subdomain
        resource.update(invitation_completed: true) if resource.admin?
      else
        resource.subdomain = request.subdomain
        resource.role = :member
        resource.update(invitation_completed: true)
      end
    end
  end
end
