# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if current_user
      if current_user.super_admin?
        @admins = User.where(role: :admin)
        render 'admins/index'
      elsif current_user.admin?
        if current_user.invitation_completed
          redirect_to admin_my_church_path
        else
          flash.clear
          flash.now[:error] = 'Invitation not accepted yet. Resending invitation now.'
          current_user.create_invitation_token
          sign_out current_user
        end
      else
        redirect_to member_home_path
      end
      # else
      # new_user_session_path
    end
  end

  def fetch_signed_url
    if current_user.present?
      timestamp = Time.now.to_i
      key = "user/#{current_user.id}/mediasermon/#{timestamp}.mp4"
      obj = s3_bucket.object(key)
      render json: { url: obj.presigned_url(:put), method: 'put' } # fields: params.permit(:filename) }
    else
      render json: { error: 'No user found' }, status: 404
    end
  end

  private

  def s3_bucket
    s3 = Aws::S3::Resource.new(
      region: 'us-west-1',
      access_key_id: ENV['ACCESS_KEY_ID'],
      secret_access_key: ENV['SECRET_ACCESS_KEY']
    )
    s3.bucket(ENV['S3_BUCKET'])
  end
end
