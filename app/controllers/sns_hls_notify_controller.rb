class SnsHlsNotifyController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_request_authenticity

  # @url /notifications
  #
  # @action POST
  #
  # Broadcasts a SNS message to an ActionCable channel
  #
  #
  def notify
    case message_body['Type']
    when 'SubscriptionConfirmation'
      puts message_body['TopicArn']
      confirm_subscription ? (head :ok) : (head :bad_request)
    when 'Notification'
      message = JSON.parse(message_body['Message'])
      puts message
      if message['state'] == 'COMPLETED'
        save_hls_and_thumbnail_url(message)
      end
      head :ok
    end
  end

  private

  def save_hls_and_thumbnail_url(message)
    id = message['outputKeyPrefix'].split('/')[1]
    media_sermon = Admin::MediaSermon.find_by(id: id)
    return unless media_sermon.present?

    hls_url = "https://#{ENV['CLOUDFRONT_URL']}/#{message['outputKeyPrefix']}" \
                  "#{message['playlists'][0]['name']}.m3u8"
    media_sermon.update hls_url: hls_url, hls_thumbnail_url: fetch_thumbnail_url(message)
    message['outputKeyPrefix']
  end

  def fetch_thumbnail_url(message)
    s3_client = Aws::S3::Client.new
    files = s3_client.list_objects(bucket: 'sda-live-hls', prefix: message['outputKeyPrefix']).contents
    thumbnail_pattern = message['outputs'].last['thumbnailPattern'].split('-')[0]
    thumbnail_url = nil
    files.each do |file|
      thumbnail_url = "https://#{ENV['CLOUDFRONT_URL']}/#{file.key}" if file.key.index(thumbnail_pattern).present?
    end
    thumbnail_url
  end

  def verify_request_authenticity
    head :unauthorized if raw_post.blank? || !message_verifier.authentic?(raw_post)
  end

  def raw_post
    @raw_post ||= request.raw_post
  end

  def message_body
    @message_body ||= JSON.parse(raw_post)
  end

  def message_verifier
    @message_verifier ||= Aws::SNS::MessageVerifier.new
  end

  def confirm_subscription
    AWS_SNS_CLIENT.confirm_subscription(
      topic_arn: message_body['TopicArn'],
      token: message_body['Token']
    )
    true
  rescue Aws::SNS::Errors::ServiceError => e
    Rails.logger.info(e.message)
    false
  end
end