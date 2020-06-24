Aws.config.update(
  {
    region: 'us-west-1',
    credentials: Aws::Credentials.new(ENV['access_key_id'], ENV['secret_access_key'])
  }
)
AWS_SNS_CLIENT = Aws::SNS::Client.new(
  region: 'us-west-1',
  credentials: Aws::Credentials.new(ENV['access_key_id'], ENV['secret_access_key'])
)