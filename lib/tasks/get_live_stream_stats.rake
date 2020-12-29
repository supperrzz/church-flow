# frozen_string_literal: true

task get_live_stream_stats: :environment do
  puts '############  Get Live Stream Stats  ############'
  # Start time
  start_time = 13.hours.ago.beginning_of_hour
  end_time = 12.hours.ago.beginning_of_hour
  usage_api = MuxRuby::DeliveryUsageApi.new
  usage = usage_api.list_delivery_usage(timeframe: [start_time.to_i, end_time.to_i])
  usage.data.each do |asset|
    live_stream = Admin::LiveStream.find_by(mux_stream_id: asset['live_stream_id'])
    live_stream.admin_live_stream_stats.create(
      asset_id: asset['asset_id'],
      asset_created_at: Time.at(asset['created_at'].to_i),
      asset_duration: asset['asset_duration'],
      delivered_seconds: asset['delivered_seconds']
    )
  end
  LivestreamStat.create(data: usage.data, start_time: start_time, end_time: end_time, status: '200')
  puts '############  Completed Get Live Stream Stats  ############'
rescue MuxRuby::ApiError => _e
  LivestreamStat.create(data: usage.data, start_time: start_time, end_time: end_time, status: '400')
end
