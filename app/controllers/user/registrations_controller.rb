# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    super do |resource|
      resource.update(invitation_completed: true) if resource.admin?
    end
  end
end
