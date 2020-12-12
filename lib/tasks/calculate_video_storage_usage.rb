# frozen_string_literal: true

task calculate_video_storage_usage: :environment do
  puts '############  Calculate Video Storage Usage  ############'
  User.where(role: :admin).each do |user|
    video_storage = 0 # In Bytes
    user.subscription_profile.create unless user.subscription_profile.present?
    user.admin_media_sermons.each do |media_sermon|
      video_storage += media_sermon.video.metadata['size'] if media_sermon.video.present?
      video_storage += media_sermon.thumbnail.metadata['size'] if media_sermon.thumbnail.present?
    end
    user.subscription_profile.update(video_storage: video_storage)
  end
  puts '############  Finished Calculated Video Storage Usage  ############'
end
