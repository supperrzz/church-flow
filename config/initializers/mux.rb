MuxRuby.configure do |config|
  if Rails.env.development?
    config.username = 'db0bbfb2-512a-4921-9129-1b79f66125f2'
    config.password = 'eLcKvP2EQAsDVlz+YtM3q5Zz2GSIyDn1aQ8M8P1iN6kmlfcE0Wj5ueSALpOMxb2QtInRxFU5xVo'
  else
    config.username = ENV['MUX_TOKEN_ID']
    config.password = ENV['MUX_TOKEN_SECRET']
  end
end