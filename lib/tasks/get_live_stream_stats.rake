# frozen_string_literal: true

task get_live_stream_stats: :environment do
  puts '############  Get Live Stream Stats  ############'
  # Start time
  start_time = 13.hours.ago.beginning_of_hour
  end_time = 12.hours.ago.beginning_of_hour
  usage_api = MuxRuby::DeliveryUsageApi.new
  usage = usage_api.list_delivery_usage(timeframe: [start_time.to_i, end_time.to_i])
  LivestreamStat.create(data: usage.data, start_time: start_time, end_time: end_time, status: '200')
  puts '############  Completed Get Live Stream Stats  ############'
rescue MuxRuby::ApiError => _e
  LivestreamStat.create(data: usage.data, start_time: start_time, end_time: end_time, status: '400')
end
