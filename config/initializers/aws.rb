Aws.config.update(
  {
    region: ENV['S3_BUCKET_REGION'],
    credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY']),
    endpoint:'https://s3.us-east-2.amazonaws.com'
  }
)
AWS_SNS_CLIENT = Aws::SNS::Client.new(
  region: ENV['S3_BUCKET_REGION'],
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
)