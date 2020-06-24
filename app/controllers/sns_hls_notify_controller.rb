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
      head :ok
      # confirm_subscription ? (head :ok) : (head :bad_request)
    when 'Notification'
      message = JSON.parse(message_body['Message'])
      puts message
      head :ok
    end
  end

  private

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