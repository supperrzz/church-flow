Aws.config.update(
  {
    region: 'us-west-1',
    credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
  }
)
AWS_SNS_CLIENT = Aws::SNS::Client.new(
  region: 'us-west-1',
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
)