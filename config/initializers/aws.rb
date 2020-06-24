Aws.config.update(
  {
    region: 'us-west-1',
    credentials: Aws::Credentials.new(ENV['access_key_id'], ENV['secret_access_key'])
  }
)
