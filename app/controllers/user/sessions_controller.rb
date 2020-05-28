# frozen_string_literal: true

# Override
class User::SessionsController < Devise::SessionsController

    # POST /resource
    def create
      super
=begin
      super do |resource|
        if resource.admin?
          sign_in resource, scope: resource.website.subdomain
        end
      end
=end
    end
end